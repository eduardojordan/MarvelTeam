//
//  NetworkError.swift
//  MarvelTeam
//
//  Created by Eduardo Jordan on 28/1/22.
//

import Foundation

enum NetworkError: Error {
    case specificError
    case genericError
    
    var description: String {
          switch self {
          case .specificError:
              return localizedString("error_specific")
          case .genericError:
              return localizedString("error_generic")
          }
      }
}
