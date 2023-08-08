//
//  MainCoordinator.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Combine
import Foundation

protocol MainCoordinatorProtocol: CoordinatorProtocol, ActionHandlerProtocol where ActionType == CommonAction.ServiceAction {}

class MainCoordinator: BaseCoordinator, MainCoordinatorProtocol {
    typealias ActionType = CommonAction.ServiceAction
    
    func handleAction(_ action: ActionType, completion: ActionHandlerCompletion?) {
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
