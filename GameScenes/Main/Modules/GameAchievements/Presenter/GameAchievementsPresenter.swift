//
//  GameAchievementsPresenter.swift
//  GameAchievementsScenes
//
//  Created by Михаил Игонин on 27.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UICommon
import Core
import UIKit
import Services

class GameAchievementsPresenter: Coordinatable, GameAchievementsViewOutput, GameAchievementsInteractorOutput {
    typealias InputType = GameAchievementsModuleStartOption
    typealias OutputType = GameAchievementsModuleResult

    weak var view: GameAchievementsViewInput!
    var interactor: GameAchievementsInteractorInput!
    
    var errorDescriber: ErrorDescribing!
    var modelBuilder: GameAchievementsModelBuilding!

    var output: ((GameAchievementsModuleResult) -> Void)?

    // MARK: Local enviroment
    var state = GameAchievementsPresenterState()
    var displayModels = [GameAchievementsCellModel]()

    // MARK: Coordinatable
    func start(with option: GameAchievementsModuleStartOption, animated: Bool) {
        switch option {
        case .gameAchievements(let game, let user):
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

        view.setTitle(L10n.Achievements.title)
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

    // MARK: - GameAchievementsViewOutput

    // MARK: - GameAchievementsInteractorOutput
    func loadModels() {
        let achievements = interactor.provideGameAchievements()
        let settings = GameAchievementsModelBuilderSettings(achievements: achievements)

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

extension GameAchievementsPresenter: GameAchievementsItemsSourcing {
    func numberOfSections() -> Int {
        return 1
    }

    func itemsInSection(index: Int) -> Int {
        return displayModels.count
    }

    func itemModelFor(indexPath: IndexPath) -> GameAchievementsCellModel {
        return displayModels[indexPath.row]
    }
}
