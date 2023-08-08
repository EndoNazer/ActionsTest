//
//  AnyActionHandler.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Foundation

class AnyActionHandler<Action: ActionProtocol>: ActionHandlerProtocol {
    typealias ActionType = Action

    private let _handler: (Action, ActionHandlerCompletion?) -> Void
    
    init<T: ActionHandlerProtocol>(_ handler: T) where T.ActionType == ActionType {
        _handler = {
            handler.handleAction($0, completion: $1)
        }
    }

    func handleAction(_ action: Action, completion: ActionHandlerCompletion?) {
        _handler(action, completion)
    }
}
