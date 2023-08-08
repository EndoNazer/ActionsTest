//
//  AppCoordinator.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import Combine
import Foundation

protocol AppCoordinatorProtocol: CoordinatorProtocol, ActionHandlerProtocol {}

class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol, MainActionHandlerProtocol {
    typealias ActionType = CommonAction.MainAction

    let actionQueue = DispatchQueue(label: "ActionHandlers queue", qos: .userInteractive)
    var actionHandlers: [any ActionHandlerProtocol] = []

    private var childCoorinators: [CoordinatorProtocol] = []
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
        
        addTab()
    }
}

// MARK: ActionHandlerProtocol

extension AppCoordinator {
    func handleAction(_ action: CommonAction.MainAction, completion: ActionHandlerCompletion? = nil) {
        switch action {
        case .resetRoot:
            print("RESET ROOT")
            completion?(true)
        case let .finish(coordinator):
            childCoorinators.removeAll(where: { $0 === coordinator })
            print("FINISH")
            completion?(true)
        }
    }
}

// MARK: Screens

extension AppCoordinator {
    private func addTab() {
        let tabCoordinator: any TabCoordinatorProtocol = TabCoordinator(outputRoutes: self)
        childCoorinators.append(tabCoordinator)
        actionHandlers.append(AnyActionHandler(tabCoordinator))
        
        tabCoordinator.start()
    }

    private func addService() {
        let serviceCoordinator: any ServiceCoordinatorProtocol = ServiceCoordinator()
        childCoorinators.append(serviceCoordinator)
        actionHandlers.append(AnyActionHandler(serviceCoordinator))
        
        serviceCoordinator.start()
    }
    
    private func addMain() {
        let mainCoordinator: any MainCoordinatorProtocol = MainCoordinator()
        childCoorinators.append(mainCoordinator)
        actionHandlers.append(AnyActionHandler(mainCoordinator))
        
        mainCoordinator.start()
    }
}

extension AppCoordinator: TabOutputRoutes {
    func showProduct() {
        let productCoordinator: ProductCoordinatorProtocol = ProductCoordinator()
        childCoorinators.append(productCoordinator)

        productCoordinator.actionSenderSubject = actionSenderSubject
        productCoordinator.start()
    }
}
