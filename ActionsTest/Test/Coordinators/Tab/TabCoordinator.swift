//
//  TabCoordinator.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Combine
import Foundation

protocol TabCoordinatorProtocol: CoordinatorProtocol, ActionHandlerProtocol where ActionType == CommonAction.TabAction {}

class TabCoordinator: BaseCoordinator, TabCoordinatorProtocol {
    typealias ActionType = CommonAction.TabAction
    
    func handleAction(_ action: ActionType, completion: ActionHandlerCompletion?) {
        switch action {
        case .switchTab:
            print("SWITCH TAB")
            completion?(true)
        case .playAnimation:
            print("PLAY ANIMATION")
            completion?(true)
        }
    }
    
    private weak var outputRoutes: TabOutputRoutes?
    
    init(outputRoutes: TabOutputRoutes?) {
        self.outputRoutes = outputRoutes
    }

    override func start() {
        outputRoutes?.showProduct()
    }
}
