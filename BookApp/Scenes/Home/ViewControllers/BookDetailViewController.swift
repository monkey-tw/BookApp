//
//  BookDetailViewController.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/20.
//

import UIKit
import SwiftUI

class BookDetailViewController: UIHostingController<BookDetailPageView> {

    init() {
        let pageView = BookDetailPageView()
        super.init(rootView: pageView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
