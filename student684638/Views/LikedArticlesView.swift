//
//  LikedArticlesView.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import SwiftUI
import Combine

struct LikedArticleView: View {
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    var body: some View {
        
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error, handler: { viewModel.getLikedArticles() })
                case .success(let articles):
                        List(articles) {
                            item in
                            NavigationLink(destination: ArticleDetail(article: item)){
                                HStack{
                                    ArticleCell(article: item)
                                    if(item.isLiked){
                                        Image(systemName: "star.fill").foregroundColor(.yellow)
                                    }
                                    else{
                                        Image(systemName: "star").foregroundColor(.yellow)
                                    }
                                    
                                }
                            }
                        }.navigationTitle("Favorieten")
                    }
                }.onAppear(perform: {
                    viewModel.getLikedArticles() })
            }
    }

struct LikedArticleView_Previews: PreviewProvider {
    static var previews: some View {
        LikedArticleView()
    }
}
