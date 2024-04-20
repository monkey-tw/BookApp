//
//  AddBookViewController.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import UIKit
import SwiftUI
import Platform
import Combine

class AddBookViewController: UIHostingController<AddBookPageView> {
    let viewModel: AddBookViewModel
    private var cancellable: Set<AnyCancellable> = .init()
    
    init(viewModel: AddBookViewModel) {
        self.viewModel = viewModel
        let pageView = AddBookPageView(viewModel: viewModel)
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
        viewModel.$newBook.sink {[weak self] model in
            if model != nil {
                LoadingView.succeed("Add Book Successfully")
                self?.viewModel.sendAction(.backToHomePage)
            }
        }.store(in: &cancellable)
        
        viewModel.$requestError.sink { error in
            if let localizedDescription = error?.localizedDescription {
                LoadingView.failed(localizedDescription)
            }
        }.store(in: &cancellable)
    }
}