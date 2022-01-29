//
//  ViewModelCharacter.swift
//  MarvelTeam
//
//  Created by Eduardo Jordan on 28/1/22.
//

import UIKit

class ViewModelCharacter {
    
    var refreshData = { () -> () in }
    var characterData : [DataCharacter] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retrieveData(page: String) {
        let apiService = MarvelAPI()
        apiService.apiToGetCharacterData(page: page) { characterData in
            switch characterData {
            case .success (let character):
                self.characterData.append(contentsOf: character.data!.results)
            case .failure(let error):
                if (error == .specificError) {
                    print(error.localizedDescription)
                } else {
                    print(NetworkError.genericError)
                }
            }
        }
    }
    
}
