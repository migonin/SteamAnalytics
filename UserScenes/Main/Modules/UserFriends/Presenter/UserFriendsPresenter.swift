//
//  UserFriendsPresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core

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
        loadModels()
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle("Друзья \(state.user.name)")
    }

    func willAppear(animated: Bool) {
        state.isViewWillPresented = true

        interactor.subscribeForDataSourceChanges()
    }
    
    func didAppear(animated: Bool) {
        state.isViewWillPresented = false
        state.isViewPresented = true

        interactor.loadUserFriends()
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
        interactor.loadUserFriends()
    }

    // MARK: - UserFriendsInteractorOutput
    func didStartUserFriendsLoading() {
        if interactor.provideUserFriends().isEmpty {
            view.showSpinner()
        }
    }

    func didFinishUserFriendsLoading(result: Result<Void, Error>) {
        view.hideSpinner()

        if case let Result.failure(error) = result {
            switch errorDescriber.describeError(error) {
            case .message(let message, let okTitle, let retryTitle),
                 .networkError(let message, let okTitle, let retryTitle):
                    view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)
            }
        }
    }

    func loadModels() {
        let friends = interactor.provideUserFriends()
        let settings = UserFriendsModelBuilderSettings(friends: friends)

        displayModels = modelBuilder.buildModels(settings: settings)
    }

    func userChanged() {
        loadModels()
        view.reloadData()
    }

    func didTapCell(at index: Int) {
        switch displayModels[index] {
        case .user(let user, _):
            output?(.userTapped(user))
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
