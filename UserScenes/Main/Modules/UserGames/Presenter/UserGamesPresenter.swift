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
        case .user(let user):
            state.user = user
        }

        interactor.prepareDataSource(user: state.user)
        loadModels()
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle("Игры \(state.user.name)")
        interactor.loadUserGames()
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
        interactor.loadUserGames()
    }

    // MARK: - UserGamesInteractorOutput
    func didStartUserGamesLoading() {
        if interactor.provideUserGames().isEmpty {
            view.showSpinner()
        }
    }

    func didFinishUserGamesLoading(result: Result<Void, Error>) {
        view.hideSpinner()

        if case let Result.failure(error) = result {
            switch errorDescriber.describeError(error) {
            case .message(let message, let okTitle, let retryTitle),
                 .networkError(let message, let okTitle, let retryTitle):
                    view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)

            case .wrongResponse:
                break
//                view.showError(message: "Игры пользователя недоступны", okButtonTitle: "Назад", retryButtonTitle: nil)
            }
        }
    }

    func loadModels() {
        let games = interactor.provideUserGames()
        let settings = UserGamesModelBuilderSettings(games: games)

        displayModels = modelBuilder.buildModels(settings: settings)
    }

    func userChanged() {
        loadModels()
        view.reloadData()
    }

    func didTapCell(at index: Int) {
        switch displayModels[index] {
        case .game(let game, _):
            output?(.gameTapped(game))
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
