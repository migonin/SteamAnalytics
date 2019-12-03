//
//  LoginViewOutput.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

protocol LoginViewOutput {

    func didLoad()
    func willAppear(animated: Bool)
    func didAppear(animated: Bool)
    func willDisappear(animated: Bool)
    func didDisappear(animated: Bool)

    func didTapRetryButton()

    func shouldStartLoad(url: URL?) -> Bool
    func didStartLoad(url: URL?)
    func didFinishLoad(url: URL?)
    func didFailLoad(url: URL?, with error: Error)

    func fakeLoginTapped()
    func reloadTapped()
}
