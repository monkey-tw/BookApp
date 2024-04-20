//
//  ViewController.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import UIKit
import SwiftUI
import Combine
import Platform

class HomeViewController: UIHostingController<HomePageView> {
    let viewModel: HomeViewModel
    private var cancellable: Set<AnyCancellable> = .init()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        let pageView = HomePageView(viewModel: viewModel)
        super.init(rootView: pageView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Book List"
        setupViews()
        setupBindings()
        
        viewModel.sendAction(.requestBookList)
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonDidCilcked))
    }

    private func setupBindings() {
        viewModel.$requestError.sink { error in
            if let localizedDescription = error?.localizedDescription {
                LoadingView.failed(localizedDescription)
            }
        }.store(in: &cancellable)
    }
    
    // MARK: - Event
    @objc private func addButtonDidCilcked() {
        viewModel.sendAction(.pushToAddBookPage)
    }
}

