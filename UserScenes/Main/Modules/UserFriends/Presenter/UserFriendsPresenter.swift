//
//  UserFriendsPresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core
import Services

class UserFriendsPresenter: Coordinatable, UserFriendsViewOutput, UserFriendsInteractorOutput {
    typealias InputType = UserFriendsModuleStartOption
    typealias OutputType = UserFriendsModuleResult

    weak var view: UserFriendsViewInput!
    var interactor: UserFriendsInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: UserFriendsModelBuilding!

    var output: ((UserFriendsModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = UserFriendsPresenterState()
    var displayModels = [UserFriendsCellModel]()

    // MARK: Coordinatable
    func start(with option: UserFriendsModuleStartOption, animated: Bool) {
        switch option {
        case .user(let user):
            state.user = user
        }

        interactor.prepareDataSource(user: state.user)
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle(L10n.UserFriends.title(state.user.name))
        interactor.loadUserFriends(force: false)
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

    // MARK: - UserFriendsViewOutput

    func didTapOKButton() {
        output?(.back)
    }

    func didTapRetryButton() {
        interactor.loadUserFriends(force: true)
    }

    func didRefresh() {
        interactor.loadUserFriends(force: true)
    }

    // MARK: - UserFriendsInteractorOutput
    func didStartUserFriendsLoading() {
        state.requestInProgress = true

        if interactor.provideUserFriends().isEmpty {
            view.showSpinner()
        }
    }

    func didFinishUserFriendsLoading(result: Result<Void, Error>) {
        state.requestInProgress = false
        view.hideSpinner()
        view.setPullToRefreshActive(false)

        if case let Result.failure(error) = result {
            switch errorDescriber.describeError(error) {
            case .message(let message, let okTitle, let retryTitle),
                 .networkError(let message, let okTitle, let retryTitle):
                    view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)

            case .wrongResponse:
                state.infoInaccessibleError = true
                reloadScreen()
            }
        }
    }

    func loadModels() {
        let friends = interactor.provideUserFriends()
        let settings = UserFriendsModelBuilderSettings(friends: friends,
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
        case .user(let user, _):
            output?(.userTapped(user))
        default:
            break
        }
    }
}

extension UserFriendsPresenter: UserFriendsItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> UserFriendsCellModel {
        return displayModels[indexPath.row]
    }
}
