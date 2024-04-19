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
        
        let navigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(dependencies: dependencies, navigationController: navigationController)
        homeCoordinator.start()
        
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = navigationController
    }
}
