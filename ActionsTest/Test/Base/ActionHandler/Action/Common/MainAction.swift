//
//  MainAction.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Foundation

extension CommonAction {
    enum MainAction: ActionProtocol {
        case resetRoot
        case finish(coordinator: CoordinatorProtocol)
    }
}
