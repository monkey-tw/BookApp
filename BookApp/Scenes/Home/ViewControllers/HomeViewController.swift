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
        setupNotifications()
        
        viewModel.sendAction(.requestBookList(isShowLoading: true))
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonDidCilcked))
    }

    private func setupBindings() {
        viewModel.loadStatus.sink { status in
            switch status {
            case .loading:
                LoadingView.show()
            case .loadSuccess:
                LoadingView.hide()
            case .loadFailure(let error):
                if let localizedDescription = error?.localizedDescription {
                    LoadingView.failed(localizedDescription)
                }
            }
        }.store(in: &cancellable)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(forName: .bookDidUpdated, object: nil, queue: nil) {[weak self] _ in
            self?.viewModel.sendAction(.requestBookList(isShowLoading: false))
        }
        NotificationCenter.default.addObserver(forName: .bookDidAdded, object: nil, queue: nil) {[weak self] _ in
            self?.viewModel.sendAction(.requestBookList(isShowLoading: false))
        }
        NotificationCenter.default.addObserver(forName: .bookDidDeleted, object: nil, queue: nil) {[weak self] _ in
            self?.viewModel.sendAction(.requestBookList(isShowLoading: false))
        }
    }
    
    // MARK: - Event
    @objc private func addButtonDidCilcked() {
        viewModel.sendAction(.pushToAddBookPage)
    }
}

