//
//  AddBookViewController.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import UIKit
import SwiftUI

class AddBookViewController: UIHostingController<AddBookPageView> {
    
    init() {
        let pageView = AddBookPageView()
        super.init(rootView: pageView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
