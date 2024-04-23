//
//  SettingsViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import Foundation
import Networking

class SettingsViewModel {
    enum Action {
        case changeChannel(BaseUrlChannel)
    }
    var baseUrlManager: BaseUrlManager
    
    init(baseUrlManager: BaseUrlManager) {
        self.baseUrlManager = baseUrlManager
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .changeChannel(let baseUrlChannel):
            baseUrlManager.channel = baseUrlChannel
        }
    }
}
