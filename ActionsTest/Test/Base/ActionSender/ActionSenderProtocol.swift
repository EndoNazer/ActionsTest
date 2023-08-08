//
//  ActionSenderProtocol.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Combine
import Foundation

protocol ActionSenderProtocol: AnyObject {
    var actionSenderSubject: PassthroughSubject<ActionProtocol, Never>? { get set }
}
