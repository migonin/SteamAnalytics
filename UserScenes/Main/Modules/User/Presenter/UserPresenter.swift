//
//  UserPresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon

class UserPresenter: Coordinatable, UserViewOutput, UserInteractorOutput {
    typealias InputType = UserModuleStartOption
    typealias OutputType = UserModuleResult

    weak var view: UserViewInput!
    var interactor: UserInteractorInput!

    // MARK: Local enviroment
    var state = UserPresenterState()

    // MARK: Coordinatable
    func start(with option: UserModuleStartOption, animated: Bool) {

    }

    var output: ((UserModuleResult) -> Void)?

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
    }
    
    func willDisappear(animated: Bool) {
        
    }
    
    func didDisappear(animated: Bool) {
        state.isViewPresented = false
    }

    // MARK: - UserViewOutput

    func didTapRetryButton() {

    }

    // MARK: - UserInteractorOutput

}
