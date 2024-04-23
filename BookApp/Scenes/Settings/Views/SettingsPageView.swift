//
//  SettingsPageView.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/23.
//

import SwiftUI
import Networking

struct SettingsPageView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        List {
            HStack {
                Text("Base url channel")
                Picker(selection: $viewModel.channel, label: Text("channel")) {
                    Text("AWS").tag(BaseUrlChannel.aws)
                    Text("Local").tag(BaseUrlChannel.local)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}
