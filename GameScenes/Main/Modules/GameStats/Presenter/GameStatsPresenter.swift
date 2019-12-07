//
//  GameStatsPresenter.swift
//  GameStatsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core
import UIKit
import Services

class GameStatsPresenter: Coordinatable, GameStatsViewOutput, GameStatsInteractorOutput {
    typealias InputType = GameStatsModuleStartOption
    typealias OutputType = GameStatsModuleResult

    weak var view: GameStatsViewInput!
    var interactor: GameStatsInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: GameStatsModelBuilding!

    var output: ((GameStatsModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = GameStatsPresenterState()
    var displayModels = [GameStatsCellModel]()

    // MARK: Coordinatable
    func start(with option: GameStatsModuleStartOption, animated: Bool) {
        switch option {
        case .gameStats(let game, let user):
            state.game = game
            state.user = user
        }

        interactor.prepareDataSource(game: state.game, of: state.user)
    }

    // MARK: View lifecycle
    func didLoad() {
        state.isViewLoaded = true
        state.isViewWillPresented = false
        state.isViewPresented = false

        view.setTitle(L10n.GameStats.title)
        view.setPullToRefreshEnabled(false)
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

    // MARK: - GameStatsViewOutput
    func graph(withID id: String, didChangeTransform transform: CGAffineTransform) {
        view.changeTransform(transform, forGraphsExcept: id)
    }

    // MARK: - GameStatsInteractorOutput
    func loadModels() {
        let stats = interactor.provideGameStats()
        let settings = GameStatsModelBuilderSettings(stats: stats)

        displayModels = modelBuilder.buildModels(settings: settings)
    }

    func reloadScreen() {
        loadModels()
        view.reloadData()
    }

    func gameChanged() {
        reloadScreen()
    }

    func didTapCell(at index: Int) {
    }
}

extension GameStatsPresenter: GameStatsItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> GameStatsCellModel {
        return displayModels[indexPath.row]
    }
}
