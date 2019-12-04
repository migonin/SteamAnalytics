//
//  UserGamesPresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core

class UserGamesPresenter: Coordinatable, UserGamesViewOutput, UserGamesInteractorOutput {
    typealias InputType = UserGamesModuleStartOption
    typealias OutputType = UserGamesModuleResult

    weak var view: UserGamesViewInput!
    var interactor: UserGamesInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: UserGamesModelBuilding!

    var output: ((UserGamesModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = UserGamesPresenterState()
    var displayModels = [UserGamesCellModel]()

    // MARK: Coordinatable
    func start(with option: UserGamesModuleStartOption, animated: Bool) {
        switch option {
        case .allGames(let user):
            state.user = user
        case .lastPlayedGames(let user):
            state.user = user
            state.lastPlayedGamed = true
        }

        interactor.prepareDataSource(user: state.user)
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        if state.lastPlayedGamed {
            view.setTitle("Последние игры \(state.user.name)")
        } else {
            view.setTitle("Игры \(state.user.name)")
        }
        
        interactor.loadUserGames(lastPlayed: state.lastPlayedGamed)
        loadModels()
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

    // MARK: - UserGamesViewOutput

    func didTapOKButton() {
        output?(.back)
    }

    func didTapRetryButton() {
        interactor.loadUserGames(lastPlayed: state.lastPlayedGamed)
    }

    // MARK: - UserGamesInteractorOutput
    func didStartUserGamesLoading() {
        state.requestInProgress = true

        if interactor.provideUserGames(lastPlayed: state.lastPlayedGamed).isEmpty {
            view.showSpinner()
        }
    }

    func didFinishUserGamesLoading(result: Result<Void, Error>) {
        state.requestInProgress = false
        view.hideSpinner()

        if case let Result.failure(error) = result {
            switch errorDescriber.describeError(error) {
            case .message(let message, let okTitle, let retryTitle),
                 .networkError(let message, let okTitle, let retryTitle):
                if state.lastPlayedGamed {
                    view.showError(message: message, okButtonTitle: nil, retryButtonTitle: retryTitle)
                } else {
                    view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)
                }

            case .wrongResponse:
                state.infoInaccessibleError = true
                reloadScreen()
            }
        }
    }

    func loadModels() {
        let games = interactor.provideUserGames(lastPlayed: state.lastPlayedGamed)
        let settings = UserGamesModelBuilderSettings(games: games,
                                                     requestInProgress: state.requestInProgress,
                                                     infoInaccessibleError: state.infoInaccessibleError)

        displayModels = modelBuilder.buildModels(settings: settings)
    }

    func reloadScreen() {
        loadModels()
        view.reloadData()
    }

    func userChanged() {
        reloadScreen()
    }

    func didTapCell(at index: Int) {
        switch displayModels[index] {
        case .game(let game, _):
            output?(.gameTapped(game))
        default:
            break
        }
    }
}

extension UserGamesPresenter: UserGamesItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> UserGamesCellModel {
        return displayModels[indexPath.row]
    }
}