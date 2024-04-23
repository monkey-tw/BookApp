//
//  SettingsCoordinator.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import UIKit

final class SettingsCoordinator {
    private let dependencies: AppDependencies
    private let navigationController: UINavigationController
    
    init(dependencies: AppDependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SettingsViewController()
        navigationController.viewControllers = [viewController]
    }
}
