//
//  ResultState.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}

enum LoginResultState {
    case noAttemptYet
    case loading
    case successLogin(content: String?)
    case failed(error: Error)
}

enum RegisterResultState {
    case noAttemptYet
    case loading
    case successRegister(content: RegisterResponse)
    case failed(error: Error)
}

enum LikeState {
    case failed(error: Error)
    case noAttemptYet
    case successLiked
    case successUnliked
}
