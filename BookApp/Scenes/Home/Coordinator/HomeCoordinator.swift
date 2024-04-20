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
        let repository = StandardHomeRepository(apiClient: dependencies.apiClient)
        let useCase = StandardHomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase, navigator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}

extension HomeCoordinator: HomeNavigator {
    func pushToAddBookPage() {
        let repository = StandardAddBookRepository(apiClient: dependencies.apiClient)
        let useCase = StandardAddBookUseCase(repository: repository)
        let viewModel = AddBookViewModel(useCase: useCase)
        let viewController = AddBookViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

