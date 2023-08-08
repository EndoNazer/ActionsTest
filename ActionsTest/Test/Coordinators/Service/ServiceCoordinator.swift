//
//  ServiceCoordinatorProtocol.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Foundation

protocol ServiceCoordinatorProtocol: CoordinatorProtocol, ActionHandlerProtocol where ActionType == CommonAction.ServiceAction {}

class ServiceCoordinator: BaseCoordinator, ServiceCoordinatorProtocol {
    typealias ActionType = CommonAction.ServiceAction

    func handleAction(_ action: CommonAction.ServiceAction, completion: ActionHandlerCompletion?) {
        switch action {
        case .showError:
            print("ERROR")
            completion?(true)
        case .showNoConnection:
            print("NO CONNECTION")
            completion?(true)
        }
    }
}
