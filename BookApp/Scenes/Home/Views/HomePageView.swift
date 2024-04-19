//
//  HomePageView.swift
//  BookApp
//
//  Created by Jiaxin Pu on 2024/4/19.
//

import SwiftUI
import Combine

struct HomePageView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        List(viewModel.books) { model in
            HomeBookItemView(bookModel: model)
        }
    }
}
