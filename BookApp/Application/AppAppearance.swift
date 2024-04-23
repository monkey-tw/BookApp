//
//  AppAppearance.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        setupNavigationBar()
        setupTabbar()
    }
    
    private static func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private static func setupTabbar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
