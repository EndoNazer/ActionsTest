//
//  MainCoordinator.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Combine
import Foundation

protocol MainCoordinatorProtocol: CoordinatorProtocol, ActionHandlerProtocol where ActionType == ServiceAction {}

class MainCoordinator: BaseCoordinator, MainCoordinatorProtocol {
    typealias ActionType = ServiceAction
    
    func handleAction(_ action: ActionType, completion: ((Bool) -> Void)?) {
        switch action {
        case .showError:
            print("SHOW ERROR IN MAIN")
            completion?(true)
        case .showNoConnection:
            print("SHOW NO CONNECTION IN MAIN")
            completion?(false)
        }
    }

    override func start() {}
}
