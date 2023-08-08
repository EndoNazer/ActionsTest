//
//  ServiceCoordinatorProtocol.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Foundation

protocol ServiceCoordinatorProtocol: CoordinatorProtocol, ActionHandlerProtocol where ActionType == ServiceAction {}

class ServiceCoordinator: BaseCoordinator, ServiceCoordinatorProtocol {
    typealias ActionType = ServiceAction

    func handleAction(_ action: ServiceAction, completion: ((Bool) -> Void)?) {
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
