//
//  UserPresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core

class UserPresenter: Coordinatable, UserViewOutput, UserInteractorOutput {
    typealias InputType = UserModuleStartOption
    typealias OutputType = UserModuleResult

    weak var view: UserViewInput!
    var interactor: UserInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: UserModelBuilding!

    var output: ((UserModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = UserPresenterState()
    var displayModels = [UserCellModel]()

    // MARK: Coordinatable
    func start(with option: UserModuleStartOption, animated: Bool) {
        switch option {
        case .startScreen(let user):
            state.startScreen = true
            state.isUserOwn = true
            state.user = user

        case .user(let user):
            state.user = user
            state.isUserOwn = interactor.isUserOwn(user)
        }

        interactor.prepareDataSource(user: state.user)
        loadModels()
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle("")

        if state.startScreen {
            view.addLogoutButton()
        }
    }

    func willAppear(animated: Bool) {
        state.isViewWillPresented = true

        interactor.subscribeForDataSourceChanges()
    }
    
    func didAppear(animated: Bool) {
        state.isViewWillPresented = false
        state.isViewPresented = true

        interactor.loadUser()
    }
    
    func willDisappear(animated: Bool) {

    }
    
    func didDisappear(animated: Bool) {
        state.isViewPresented = false

        interactor.unsubscribeForDataSourceChanges()
    }

    // MARK: - UserViewOutput

    func didTapOKButton() {
        output?(.back)
    }

    func didTapRetryButton() {
        interactor.loadUser()
    }

    func logoutButtonTapped() {
        view.showLogoutPopup()
    }

    func logoutConfirmed() {
        interactor.logout()
        output?(.logout)
    }

    // MARK: - UserInteractorOutput
    func didStartUserLoading() {
    }

    func didFinishUserLoading(result: Result<Void, Error>) {
        if case let Result.failure(error) = result {
            switch errorDescriber.describeError(error) {
            case .message(let message, let okTitle, let retryTitle),
                 .networkError(let message, let okTitle, let retryTitle):
                if state.startScreen {
                    view.showError(message: message, okButtonTitle: nil, retryButtonTitle: retryTitle)
                } else {
                    view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)
                }
            }
        }
    }

    func loadModels() {
        let settings = UserModelBuilderSettings(user: state.user,
                                                isOwn: state.isUserOwn,
                                                startScreen: state.startScreen)

        displayModels = modelBuilder.buildModels(settings: settings)
    }

    func userChanged() {
        loadModels()
        view.reloadData()
    }

    func didTapCell(at index: Int) {
        switch displayModels[index] {
        case .friends:
            output?(.friendsTapped)

        case .games:
            output?(.gamesTapped)

        default:
            break
        }
    }
}

extension UserPresenter: UserItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> UserCellModel {
        return displayModels[indexPath.row]
    }
}
