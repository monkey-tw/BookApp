//
//  AppCoordinator.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import Foundation
import UIKit
import Platform

final class AppCoordinator {
    private let dependencies: AppDependencies
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    func start(in window: UIWindow) {
        
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))
        let homeCoordinator = HomeCoordinator(dependencies: dependencies, navigationController: homeNavigationController)
        homeCoordinator.start()
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "gearshape.2"), selectedImage: UIImage(systemName: "gearshape.2.fill"))
        let settingsCoordinator = SettingsCoordinator(dependencies: dependencies, navigationController: settingsNavigationController)
        settingsCoordinator.start()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            homeNavigationController,
            settingsNavigationController
        ]
        
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = tabBarController
    }
}
