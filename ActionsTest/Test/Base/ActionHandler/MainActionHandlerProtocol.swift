//
//  MainActionHandlerProtocol.swift
//  ActionsTest
//
//  Created by Daniil on 08.08.2023.
//

import Foundation

protocol MainActionHandlerProtocol: ActionHandlerProtocol {
    var actionHandlers: [any ActionHandlerProtocol] { get }
    var actionQueue: DispatchQueue { get }
}

extension MainActionHandlerProtocol {
    func handleUndefinedAction(_ action: ActionProtocol) where Self.ActionType == CommonAction.MainAction {
        switch action {
        case let action as CommonAction.MainAction:
            handleAction(action)
        case let action as CommonAction.TabAction:
            handleSpecificAction(action: action)
        case let action as CommonAction.ServiceAction:
            handleSpecificAction(action: action)
        default:
            break
        }
    }

    func handleSpecificAction<T: ActionProtocol>(action: T) {
        let handlers = actionHandlers
            .compactMap { $0 as? AnyActionHandler<T>}
            .reversed()

        for handler in handlers {
            var isHandled = false
            actionQueue.sync {
                handler.handleAction(action) { isHandled = $0 }
            }
            if isHandled {
                break
            }
        }
    }
}
