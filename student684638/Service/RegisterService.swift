//
//  RegisterService.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import Foundation
import Combine

struct RegisterResponse: Codable {
    let Success: Bool
    let Message: String
}

struct RegisterBody: Encodable {
    let UserName: String
    let Password: String
    
    enum CodingKeys: String, CodingKey{
        case UserName = "UserName"
        case Password = "Password"
        
    }
}

protocol RegisterService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<RegisterResponse, APIError>
}

struct RegisterServiceImpl: RegisterService {
    
    func request(from endpoint: NewsAPI) -> AnyPublisher<RegisterResponse, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<RegisterResponse, APIError> in
               
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode){

                    return Just(data)
                        .decode(type: RegisterResponse.self, decoder: JSONDecoder()).mapError {
                            _ in APIError.decodingError
                        }.eraseToAnyPublisher()
                } else{
                    print(response)
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
}
