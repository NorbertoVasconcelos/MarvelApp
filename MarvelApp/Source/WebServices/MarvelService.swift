//
//  MarvelService.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 23/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import Foundation

// Marvel API
enum MarvelService {
    case getCharacters(offset: Int)
}

extension MarvelService {
    
    // Default parameters every API call should have
    private func createDefaultParameters() -> [String: AnyObject] {
        let params = ["apikey": MarvelSession.publicKey,
                      "ts": MarvelSession.timestamp,
                      "hash": MarvelSession.hash]
        return params as [String : AnyObject]
    }
    
    // API base URL
    var baseURL: String {
        return "https://gateway.marvel.com"
    }
    
    // API call path to complete request url
    var path: String {
        switch self {
            case .getCharacters(_):
            return "/v1/public/characters"
        }
    }
    
    // Request URL
    var requestURL: String {
        return baseURL + path
    }
    
    // Parameters to be placed in the header request
    var parameters: [String : AnyObject] {
        var params = createDefaultParameters()
        
        // Add any aditional parameters, depending on the request
        switch self {
        case .getCharacters(let offset):
            params.updateValue(offset as AnyObject, forKey: "offset")
            break
        }
        
        return params
    }
    
}
