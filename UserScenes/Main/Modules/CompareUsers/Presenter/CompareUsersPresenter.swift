//
//  CompareUsersPresenter.swift
//  CompareUsersScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core
import UIKit
import Services

class CompareUsersPresenter: Coordinatable, CompareUsersViewOutput, CompareUsersInteractorOutput {
    typealias InputType = CompareUsersModuleStartOption
    typealias OutputType = CompareUsersModuleResult

    weak var view: CompareUsersViewInput!
    var interactor: CompareUsersInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: CompareUsersModelBuilding!

    var output: ((CompareUsersModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = CompareUsersPresenterState()
    var displayModels = [CompareUsersCellModel]()

    // MARK: Coordinatable
    func start(with option: CompareUsersModuleStartOption, animated: Bool) {
        if case let CompareUsersModuleStartOption.compare(firstUser, secondUser) = option {
            state.firstUser = firstUser
            state.secondUser = secondUser
        }

        interactor.prepareDataSource(firstUser: state.firstUser, secondUser: state.secondUser)
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle(L10n.CompareUsers.title)
        view.setPullToRefreshEnabled(false)
        loadModels()

        interactor.getCommonGames()
    }

    func willAppear(animated: Bool) {
        state.isViewWillPresented = true
    }
    
    func didAppear(animated: Bool) {
        state.isViewWillPresented = false
        state.isViewPresented = true
    }
    
    func willDisappear(animated: Bool) {

    }
    
    func didDisappear(animated: Bool) {
        state.isViewPresented = false
    }

    // MARK: - CompareUsersViewOutput
    func didSelectGame(_ game: Game?) {
        state.game = game
        state.gameHasStats = true
        reloadScreen()

        if let game = game {
            interactor.getGameComparsion(game)
        }
    }

    // MARK: - CompareUsersInteractorOutput
    func didStartCommonGamesLoading() {
        view.showSpinner()
    }

    func didFinishCommonGamesLoading(result: Result<[Game], Error>) {
        view.hideSpinner()

        switch result {
        case .success(let games):
            state.commonGames = games
            reloadScreen()
        case .failure(let error):
            handleError(error)
        }
    }

    func didStartComparison() {
        view.showSpinner()
    }

    func didFinishComparison(result: Result<[StatComparison], Error>) {
        view.hideSpinner()

        switch result {
        case .success(let results):
            state.comparisonResults = results
            reloadScreen()
        case .failure(let error):
            handleError(error)
        }
    }

    func handleError(_ error: Error) {
        switch errorDescriber.describeError(error) {
        case .message(let message, let okTitle, let retryTitle),
             .networkError(let message, let okTitle, let retryTitle):
                view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)

        case .wrongResponse:
            state.gameHasStats = false
            reloadScreen()
        }
    }

    func loadModels() {
        let settings = CompareUsersModelBuilderSettings(
            firstUser: state.firstUser,
            secondUser: state.secondUser,
            hasCommonGames: !state.commonGames.isEmpty,
            selectedGame: state.game,
            gameHasStats: state.gameHasStats,
            comparisonResults: state.comparisonResults
        )

        displayModels = modelBuilder.buildModels(settings: settings)
    }

    func reloadScreen() {
        loadModels()
        view.reloadData()
    }

    func didTapCell(at index: Int) {
        switch displayModels[index] {
        case .chooseGame:
            view.showGameSelector(state.commonGames)
        default:
            break
        }
    }
}

extension CompareUsersPresenter: CompareUsersItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> CompareUsersCellModel {
        return displayModels[indexPath.row]
    }
}
