//
//  ViewController.swift
//  ActionsTest
//
//  Created by Daniil on 07.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var appCoordinator: (any AppCoordinatorProtocol)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        appCoordinator = AppCoordinator()
        appCoordinator?.start()
    }
}

