//
//  SettingsViewModel.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import Foundation
import Combine
import Networking

class SettingsViewModel: ObservableObject {
    enum Action {
        case changeChannel(BaseUrlChannel)
    }
    private var baseUrlManager: BaseUrlManager
    @Published var channel: BaseUrlChannel = .aws {
        didSet {
            sendAction(.changeChannel(channel))
        }
    }
    
    init(baseUrlManager: BaseUrlManager) {
        self.baseUrlManager = baseUrlManager
        channel = baseUrlManager.channel
    }
    
    func sendAction(_ action: Action) {
        switch action {
        case .changeChannel(let baseUrlChannel):
            baseUrlManager.channel = baseUrlChannel
        }
    }
}
