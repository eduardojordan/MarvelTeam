//
//  Dictionary.swift
//  MarvelTeam
//
//  Created by Eduardo Jordan on 28/1/22.
//

import Foundation
import UIKit

extension Dictionary {
    var queryString: String? {
        return self.reduce("") { "\($0!)\($1.0)=\($1.1)&" }
    }
}
