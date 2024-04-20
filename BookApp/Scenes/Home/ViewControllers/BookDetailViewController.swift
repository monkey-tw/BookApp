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
        viewModel.$newBook.sink { model in
            if model != nil {
                LoadingView.succeed("Update Book Successfully")
            }
        }.store(in: &cancellable)
    }
}
