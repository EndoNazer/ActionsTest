//
//  AnyActionHandler.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Foundation

class AnyActionHandler<Action: ActionProtocol>: ActionHandlerProtocol {
    typealias ActionType = Action

    private let _handler: (Action, ((Bool) -> Void)?) -> Void
    
    init<T: ActionHandlerProtocol>(_ handler: T) where T.ActionType == ActionType {
        _handler = {
            handler.handleAction($0, completion: $1)
        }
    }

    func handleAction(_ action: Action, completion: ((Bool) -> Void)?) {
        _handler(action, completion)
    }
}
