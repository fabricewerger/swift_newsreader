//
//  DetailViewModel.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import Foundation
import Combine

protocol DetailViewModel{
    func like(articleId: Int)
    func unlike(articleId: Int)
}

class DetailViewModelImpl: ObservableObject, DetailViewModel {
    private let service: ArticleService
    private(set) var responseCode = 0
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: LikeState = .noAttemptYet
    
    init(service: ArticleService){
        self.service = service
    }
    

    func like(articleId: Int) {
        self.state = .noAttemptYet
        let cancellable = service.request(from: .likeArticle(articleId))
            .sink {
                res in
                switch res{
                case .finished:
                    self.state = .successLiked
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: {
                (response) in self.responseCode = response
            }
        
        self.cancellables.insert(cancellable)
    }
    
    func unlike(articleId: Int) {
        self.state = .noAttemptYet
        let cancellable = service.request(from: .unlikeArticle(articleId))
            .sink {
                res in
                switch res{
                case .finished:
                    self.state = .successUnliked
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: {
                (response) in self.responseCode = response
            }
        
        self.cancellables.insert(cancellable)
    }
    
}
