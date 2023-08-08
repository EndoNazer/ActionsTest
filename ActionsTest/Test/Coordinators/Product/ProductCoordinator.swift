//
//  ProductCoordinator.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Foundation

protocol ProductCoordinatorProtocol: CoordinatorProtocol, ActionSenderProtocol {}

class ProductCoordinator: BaseCoordinator, ProductCoordinatorProtocol {
    override func start() {
        actionSenderSubject?.send(ServiceAction.showNoConnection)
    }
}
