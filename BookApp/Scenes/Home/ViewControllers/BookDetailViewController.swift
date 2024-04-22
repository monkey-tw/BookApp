//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import UIKit
import SwiftUI
import Platform
import Combine

class BookDetailViewController: UIHostingController<BookDetailPageView> {
    let viewModel: BookDetailViewModel
    private var cancellable: Set<AnyCancellable> = .init()
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        let pageView = BookDetailPageView(viewModel: viewModel)
        super.init(rootView: pageView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    private func setupBindings() {
        
        viewModel.loadStatus.sink { status in
            switch status {
            case .loading:
                LoadingView.show()
            case .loadSuccess(let type):
                switch type {
                case .deleteBook:
                    LoadingView.succeed("Delete Book Successfully")
                case .updateBook:
                    LoadingView.succeed("Update Book Successfully")
                }
            case .loadFailure(let error):
                if let localizedDescription = error?.localizedDescription {
                    LoadingView.failed(localizedDescription)
                }
            }
        }.store(in: &cancellable)
        
    }
}
