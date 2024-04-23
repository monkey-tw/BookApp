//
//  SettingsViewController.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import UIKit
import SwiftUI

class SettingsViewController: UIHostingController<SettingsPageView> {
    

    init() {
        let pageView = SettingsPageView()
        super.init(rootView: pageView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
