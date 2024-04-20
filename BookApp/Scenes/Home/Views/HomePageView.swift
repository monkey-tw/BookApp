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
        List {
            ForEach(viewModel.books.indices, id: \.self) { index  in
                HomeBookItemView(bookModel: viewModel.books[index], bookIconName: viewModel.getBookIconName(index)).onTapGesture(perform: {
                    viewModel.sendAction(.pushToBookDetailPage(viewModel.books[index]))
                })
            }
        }
    }
}
