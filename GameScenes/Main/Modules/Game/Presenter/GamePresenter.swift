//
//  GamePresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core
import Services

class GamePresenter: Coordinatable, GameViewOutput, GameInteractorOutput {
    typealias InputType = GameModuleStartOption
    typealias OutputType = GameModuleResult

    weak var view: GameViewInput!
    var interactor: GameInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: GameModelBuilding!

    var output: ((GameModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = GamePresenterState()
    var displayModels = [GameCellModel]()

    // MARK: Coordinatable
    func start(with option: GameModuleStartOption, animated: Bool) {
        switch option {
        case .game(let game, let user):
            state.game = game
            state.user = user
        }

        interactor.prepareDataSource(game: state.game, of: state.user)
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle(state.game.name)
        loadModels()
        interactor.loadGame(force: false)
    }

    func willAppear(animated: Bool) {
        state.isViewWillPresented = true

        interactor.subscribeForDataSourceChanges()
    }
    
    func didAppear(animated: Bool) {
        state.isViewWillPresented = false
        state.isViewPresented = true
    }
    
    func willDisappear(animated: Bool) {

    }
    
    func didDisappear(animated: Bool) {
        state.isViewPresented = false

        interactor.unsubscribeForDataSourceChanges()
    }

    // MARK: - GameViewOutput

    func didTapOKButton() {
        output?(.back)
    }

    func didTapRetryButton() {
        interactor.loadGame(force: true)
    }

    func didRefresh() {
        interactor.loadGame(force: true)
    }

    // MARK: - GameInteractorOutput
    func didStartGameLoading() {
        if interactor.provideGameStats().isEmpty {
            view.showSpinner()
        }
    }

    func didFinishGameLoading(result: Result<Void, Error>) {
        view.hideSpinner()
        view.setPullToRefreshActive(false)

        if case let Result.failure(error) = result {
            switch errorDescriber.describeError(error) {
            case .message(let message, let okTitle, let retryTitle),
                 .networkError(let message, let okTitle, let retryTitle):
                    view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)

            case .wrongResponse:
                state.gameHasNoStats = true
                reloadScreen()
            }
        }
    }

    func loadModels() {
        let settings = GameModelBuilderSettings(user: state.user,
                                                game: state.game,
                                                stats: interactor.provideGameStats(),
                                                gameHasNoStats: state.gameHasNoStats)

        displayModels = modelBuilder.buildModels(settings: settings)
    }

    func reloadScreen() {
        loadModels()
        view.reloadData()
    }

    func gameChanged() {
        reloadScreen()
    }

    func didTapCell(at index: Int) {
        switch displayModels[index] {
        case .achievements:
            output?(.goToAchievements)
        case .news:
            output?(.goToNews)
        case .stats:
            output?(.goToStats)
        default:
            break
        }
    }
}

extension GamePresenter: GameItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> GameCellModel {
        return displayModels[indexPath.row]
    }
}
