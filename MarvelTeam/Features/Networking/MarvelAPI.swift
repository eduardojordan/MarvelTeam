//
//  MarvelAPI.swift
//  MarvelTeam
//
//  Created by Eduardo Jordan on 28/1/22.
//

import Foundation
import CryptoSwift
import UIKit

class MarvelAPI {
    
     var marvelPage = 0
     let basePath = "https://gateway.marvel.com/v1/public/characters?"
     let pathCharacters = "/characters?"
     var limit =  100
     private let privateKey = Constants.API_KEY_PRIVATE
     private let publicKey = Constants.API_KEY_PUBLIC

    func getCredentials() -> String {
        let tsValue = Date().timeIntervalSince1970.description
        let hash = "\(tsValue)\(privateKey)\(publicKey)".md5()
        let authParams = ["ts": tsValue, "apikey": publicKey, "hash": hash]
        return authParams.queryString!
    }
    
    func apiToGetCharacterData(page: Int, completion : @escaping (Result<Characters, NetworkError>) -> Void) {
        let sourcesURL = URL(string: basePath + "limit=\(limit)&offset=\(marvelPage)&" + getCredentials())
        URLSession.shared.dataTask(with: sourcesURL!) { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        let character = try? jsonDecoder.decode(Characters.self, from: data)
                        completion(.success(character!))
                    } else {
                        completion(.failure(.genericError))
                    }
                }
            }
        }.resume()
    }

}
