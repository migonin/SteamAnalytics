//
//  GameNewsPresenter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core
import Services

class GameNewsPresenter: Coordinatable, GameNewsViewOutput, GameNewsInteractorOutput {
    typealias InputType = GameNewsModuleStartOption
    typealias OutputType = GameNewsModuleResult

    weak var view: GameNewsViewInput!
    var interactor: GameNewsInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: GameNewsModelBuilding!

    var output: ((GameNewsModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = GameNewsPresenterState()
    var displayModels = [GameNewsCellModel]()

    // MARK: Coordinatable
    func start(with option: GameNewsModuleStartOption, animated: Bool) {
        switch option {
        case .news(let game):
            state.game = game
        }

        interactor.prepareDataSource(game: state.game)
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle(L10n.GameNews.title)

        interactor.loadGameNews(force: false)
        reloadScreen()
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

    // MARK: - GameNewsViewOutput

    func didTapOKButton() {
        output?(.back)
    }

    func didTapRetryButton() {
        interactor.loadGameNews(force: true)
    }

    func didRefresh() {
        interactor.loadGameNews(force: true)
    }

    // MARK: - GameNewsInteractorOutput
    func didStartGameNewsLoading() {
        if interactor.provideGameNews().isEmpty {
            view.showSpinner()
        }
    }

    func didFinishGameNewsLoading(result: Result<Void, Error>) {
        view.hideSpinner()
        view.setPullToRefreshActive(false)

        if case let Result.failure(error) = result {
            switch errorDescriber.describeError(error) {
            case .message(let message, let okTitle, let retryTitle),
                 .networkError(let message, let okTitle, let retryTitle):
                    view.showError(message: message, okButtonTitle: okTitle, retryButtonTitle: retryTitle)

            default:
                break
            }
        }
    }

    func reloadScreen() {
        let news = interactor.provideGameNews()
        let settings = GameNewsModelBuilderSettings(news: news)

        if !news.isEmpty {
            view.showSpinner(message: L10n.GameNews.loading)

            //OHMYGOD, HEAWY HTML PROCESSING!!!111
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }

                let displayModels = self.modelBuilder.buildModels(settings: settings)

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.displayModels = displayModels

                    self.view.hideSpinner()
                    self.view.reloadData()
                }
            }
        }
    }

    func gameChanged() {
        reloadScreen()
    }

    func didTapCell(at index: Int) {
    }
}

extension GameNewsPresenter: GameNewsItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> GameNewsCellModel {
        return displayModels[indexPath.row]
    }
}
