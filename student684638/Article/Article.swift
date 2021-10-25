//
//  Article.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import Foundation

struct NewsResponse: Codable {
    let Results: [Article]
}

struct Article: Codable, Identifiable {
    let uuid = UUID()
    let id: Int
    let feed: Int
    let title: String
    let summary: String
    let publishDate: String
    let image: String
    let url: String
    let related: [String]
    let isLiked: Bool
    
    enum CodingKeys: String, CodingKey{
        case id = "Id"
        case feed = "Feed"
        case title = "Title"
        case summary = "Summary"
        case publishDate = "PublishDate"
        case image = "Image"
        case url = "Url"
        case related = "Related"
        case isLiked = "IsLiked"
    }
    
    init(id: Int, feed: Int, title: String, summary: String, publishDate: String, image: String, url: String, related: [String], categories: [NewsCategory]?, isLiked: Bool){
        self.id = id
        self.feed = feed
        self.title = title
        self.summary = summary
        self.publishDate = publishDate
        self.image = image
        self.url = url
        self.related = related
        self.isLiked = isLiked
    }
    
    
}

struct NewsCategory: Codable {
    let Id: Int
    let Name: String
    
    enum CodingKeys: String, CodingKey{
        case Id, Name
    }
}

struct NewsFeed: Identifiable {
    let id = UUID()
    let feedId: Int
    let name: String
}



extension Article{
    static var dummyData: Article {
        .init(id: 134069,
              feed: 3,
              title: "Van der Breggen en Blaak kondigen afscheid aan als wielrenster",
              summary: "Anna van der Breggen en Chantal Blaak hebben zondag hun afscheid aangekondigd als wielrenster. De wereldtoppers stoppen over respectievelijk anderhalf en twee jaar en gaan daarna verder als ploegleidster.",
              publishDate: "2020-05-10T15:14:07",
              image:"https://media.nu.nl/m/k3zx972ap9ap_sqr256.jpg/van-der-breggen-en-blaak-kondigen-afscheid-aan-als-wielrenster.jpg",
              url: "https://www.nu.nl/wielrennen/6050336/van-der-breggen-en-blaak-kondigen-afscheid-aan-als-wielrenster.html",
              related: [],
              categories: [NewsCategory(Id: 4270, Name: "Sport"), NewsCategory(Id: 4271, Name: "Wielrennen")],
              isLiked: false)
    }
}

