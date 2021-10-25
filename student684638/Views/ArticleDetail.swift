//
//  ArticleDetail.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import SwiftUI
import URLImage

struct ArticleDetail: View {
    @StateObject var viewModel = DetailViewModelImpl(service: ArticleServiceImpl())
    let article: Article
    private let localStorage: LocalStorage = .init()
    
    var body: some View {
        let token = localStorage.fetchToken()
        //        var likedStatus = article.isLiked
        
        ScrollView{
            VStack(alignment: .leading){
                Text(article.title)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.vertical, 20)
                if let imgUrl = article.image,
                   let url = URL(string: imgUrl){
                    
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 250)
                            .cornerRadius(1)
                    }
                    
                } else {
                    
                    Image(systemName: "photo.fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                }
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text(article.summary)
                            .padding(.vertical, 20)
                    }
                    
                    HStack{
                        Spacer()
                        if(token != ""){
                            switch viewModel.state{
                                
                            case .noAttemptYet:
                                if(!article.isLiked){
                                    Button("Favorite"){
                                        viewModel.like(articleId: self.article.id)
                                    }.padding(.vertical, 10)
                                        .padding(.horizontal, 30)
                                        .background(Color.yellow)
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                        .cornerRadius(5)
                                } else {
                                    Button("Unfavorite"){
                                        viewModel.unlike(articleId: self.article.id)
                                    }.padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.white)
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 12))
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 2).fill(Color.yellow))
                                }
                            case .failed(error: let error):
                                Text(error.localizedDescription)
                                
                            case .successLiked:
                                Button("Unfavorite"){
                                    viewModel.unlike(articleId: self.article.id)
                                }.padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.white)
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 2).fill(Color.yellow))
                                
                            case .successUnliked:
                                Button("Favorite"){
                                    viewModel.like(articleId: self.article.id)
                                }   .padding(.vertical, 10)
                                    .padding(.horizontal, 30)
                                    .background(Color.yellow)
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .cornerRadius(5)
                                
                            }
                        }
                        
                        Button("Delen"){
                            guard let urlShare = URL(string: self.article.url) else { return }
                            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                        }.padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .cornerRadius(5)
                        
                        Button("Lezen"){
                            UIApplication.shared.open(URL(string: self.article.url)!)
                        }.padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .cornerRadius(5)
                        Spacer()
                        
                    }.padding(.vertical, 8)
                }
                Spacer()
            }.padding(10)
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(article: Article.dummyData)
    }
}
