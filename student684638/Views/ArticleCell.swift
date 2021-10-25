//
//  ArticleCell.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import SwiftUI
import URLImage

struct ArticleCell: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .center){
            Text(article.title)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 15)
            Spacer()
            if let imgUrl = article.image,
               let url = URL(string: imgUrl){
                
                URLImage(url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 75)
                        .cornerRadius(5)
                }
            } else {
                    Image(systemName: "photo.fill")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(width: 100, height: 75)
                }
            }.padding(.horizontal, 5).padding(.vertical, 5)
        }
    }


struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: Article.dummyData)
            .previewLayout(.sizeThatFits)
    }
}

