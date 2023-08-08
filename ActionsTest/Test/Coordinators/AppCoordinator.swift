//
//  AppCoordinator.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Combine
import Foundation

protocol AppCoordinatorProtocol: CoordinatorProtocol, ActionHandlerProtocol {}

class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol {
    typealias ActionType = MainContainerAction

    func handleAction(_ action: MainContainerAction, completion: ((Bool) -> Void)? = nil) {
        switch action {
        case .resetRoot:
            print("RESET ROOT")
            completion?(true)
        case .finish:
            print("FINISH")
            completion?(true)
        }
    }

    var childCoorinators: [CoordinatorProtocol] = []
    var actionHandlers: [any ActionHandlerProtocol] = []

    private let actionQueue = DispatchQueue(label: "ActionHandlers queue", qos: .userInteractive)
    private var actionSubscription: AnyCancellable?

    override init() {
        super.init()
        actionSenderSubject = PassthroughSubject<ActionProtocol, Never>()

        actionSubscription = actionSenderSubject?.sink { [weak self] action in
            self?.handleUndefinedAction(action)
        }
    }

    override func start() {
        // Test service
    
        addService()
        addMain()

        // Tab
        
        let tabCoordinator: any TabCoordinatorProtocol = TabCoordinator(outputRoutes: self)
        actionHandlers.append(AnyActionHandler(tabCoordinator))
        
        tabCoordinator.start()
        childCoorinators.append(tabCoordinator)
    }

    private func addService() {
        let serviceCoordinator: any ServiceCoordinatorProtocol = ServiceCoordinator()
        actionHandlers.append(AnyActionHandler(serviceCoordinator))
        
        serviceCoordinator.start()
        childCoorinators.append(serviceCoordinator)
    }
    
    private func addMain() {
        let mainCoordinator: any MainCoordinatorProtocol = MainCoordinator()
        actionHandlers.append(AnyActionHandler(mainCoordinator))
        
        mainCoordinator.start()
        childCoorinators.append(mainCoordinator)
    }

    private func handleUndefinedAction(_ action: ActionProtocol) {
        switch action {
        case let action as MainContainerAction:
            handleAction(action)
        case let action as TabAction:
            handleSpecificAction(action: action)
        case let action as ServiceAction:
            handleSpecificAction(action: action)
        default:
            break
        }
    }

    private func handleSpecificAction<T: ActionProtocol>(action: T) {
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

extension AppCoordinator: TabOutputRoutes {
    func showProduct() {
        let productCoordinator: ProductCoordinatorProtocol = ProductCoordinator()
        productCoordinator.actionSenderSubject = actionSenderSubject
        productCoordinator.start()
        childCoorinators.append(productCoordinator)
    }
}
