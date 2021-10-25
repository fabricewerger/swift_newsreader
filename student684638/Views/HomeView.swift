//
//  NewsListView.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    let feedId: Int
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: { viewModel.getArticles(feedId: feedId) })
            case .success(let articles):
                List(articles) {
                    item in
                    NavigationLink(destination: ArticleDetail(article: item)){
                        HStack{
                            ArticleCell(article: item)
                            if(item.isLiked){
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                                
                            } else {
                                Image(systemName: "star").foregroundColor(.yellow)
                            }
                            
                        }
                    }
                }.navigationTitle(Text("Het nieuws"))
            }
        }.onAppear(perform: {
            viewModel.getArticles(feedId:feedId) })
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(feedId: 0)
    }
}
