//
//  HomeCoordinator.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import UIKit

final class HomeCoordinator {
    private let dependencies: AppDependencies
    private let navigationController: UINavigationController
    
    init(dependencies: AppDependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController()
        navigationController.viewControllers = [viewController]
    }
}

extension HomeCoordinator: HomeNavigator {
}

