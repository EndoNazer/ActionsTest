//
//  BaseCoordinator.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Combine
import Foundation

class BaseCoordinator: CoordinatorProtocol, ActionSenderProtocol {
    var actionSenderSubject: PassthroughSubject<ActionProtocol, Never>?

    func start() {}
}
