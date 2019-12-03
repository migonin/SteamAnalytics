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
    var urlDescriber: WebViewLoginURLDescribing!
    var webViewSignInPath: String!

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

        view.setTitle("Вход")

        loadWebView()
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

    func loadWebView() {
        guard let url = URL(string: webViewSignInPath) else { return }
        view.loadRequest(URLRequest(url: url))
    }

    // MARK: - LoginViewOutput

    func fakeLoginTapped() {
        state.userID = fakeUserID
        interactor.loadUserWithID(fakeUserID)
    }

    func reloadTapped() {
        loadWebView()
    }

    func shouldStartLoad(url: URL?) -> Bool {
        switch urlDescriber.describeUrl(url) {
        case .loggedIn(let id):

            state.userID = id
            interactor.loadUserWithID(id)

            return false

        case .other:
            return true
        }
    }

    func didStartLoad(url: URL?) {
        view.showSpinner()
    }

    func didFinishLoad(url: URL?) {
        view.hideSpinner()
    }

    func didFailLoad(url: URL?, with error: Error) {
        processError(error)
    }

    func didTapRetryButton() {
        if let id = state.userID {
            interactor.loadUserWithID(id)
        } else {
            loadWebView()
        }
    }

    // MARK: - LoginInteractorOutput
    func didStartUserLoading() {
        view.showSpinner()
    }

    func didFinishUserLoading(result: Result<Void, Error>) {
        view.hideSpinner()

        switch result {
        case .success:
            if let userID = state.userID, let user = interactor.provideUserWithID(userID) {
                output?(.loggedIn(user))
            }
        case .failure(let error):
            processError(error)
        }
    }

    func processError(_ error: Error) {
        switch errorDescriber.describeError(error) {
        case .networkError(let message, _, let retryTitle):
            view.showError(message: message, okButtonTitle: retryTitle, retryButtonTitle: nil)
        default:
            break

        }
    }
}
