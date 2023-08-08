//
//  ActionHandlerProtocol.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Foundation

protocol ActionHandlerProtocol {
    associatedtype ActionType: ActionProtocol
    
    func handleAction(_ action: ActionType, completion: ((Bool) -> Void)?)
}

extension ActionHandlerProtocol {
    func handleAction(_ action: ActionType) {
        handleAction(action, completion: nil)
    }
}
