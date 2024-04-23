//
//  SettingsViewController.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import UIKit
import SwiftUI
import Combine
import Platform

class SettingsViewController: UIHostingController<SettingsPageView> {
    let viewModel: SettingsViewModel
    private var cancellable: Set<AnyCancellable> = .init()

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        let pageView = SettingsPageView(viewModel: viewModel)
        super.init(rootView: pageView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.$channel
            .dropFirst()
            .sink { channel in
                LoadingView.succeed("Updated base url to \(channel)")
            }.store(in: &cancellable)
    }
}
