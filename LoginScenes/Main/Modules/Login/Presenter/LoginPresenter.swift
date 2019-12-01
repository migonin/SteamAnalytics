//
//  LoginPresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Services
import Core

class LoginPresenter: Coordinatable, LoginViewOutput, LoginInteractorOutput {
    typealias InputType = EmptyOption
    typealias OutputType = LoginModuleResult

    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var errorDescriber: ErrorDescribing!

    let fakeUserID = "76561198324029511"

    // MARK: Local enviroment
    var state = LoginPresenterState()

    // MARK: Coordinatable
    func start(with option: EmptyOption, animated: Bool) {
    }

    var output: ((LoginModuleResult) -> Void)?

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false
    }
    
    func willAppear(animated: Bool) {
        state.isViewWillPresented = true
    }
    
    func didAppear(animated: Bool) {
        state.isViewWillPresented = false
        state.isViewPresented = true

        interactor.loadUserWithID(fakeUserID)
    }
    
    func willDisappear(animated: Bool) {
        
    }
    
    func didDisappear(animated: Bool) {
        state.isViewPresented = false
    }

    // MARK: - LoginViewOutput

    func didTapOKButton() {
        
    }

    func didTapRetryButton() {

    }

    // MARK: - LoginInteractorOutput
    func didStartUserLoading() {
        view.showSpinner()
    }

    func didFinishUserLoading(result: Result<Void, Error>) {
        view.hideSpinner()

        switch result {
        case .success:
            if let user = interactor.provideUserWithID(fakeUserID) {
                output?(.loggedIn(user))
            }
        case .failure(let error):
            switch errorDescriber.describeError(error) {
            case .message(let message, _, let retryTitle),
                 .networkError(let message, _, let retryTitle):
                view.showError(message: message, okButtonTitle: retryTitle, retryButtonTitle: nil)
            }
        }
    }

}
