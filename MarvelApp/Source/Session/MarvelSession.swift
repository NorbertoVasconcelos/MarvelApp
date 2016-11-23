//
//  MarvelSession.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 23/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import Foundation

struct MarvelSession {
    
    static var timestamp: String {
        return NSDate().description
    }
    
    static var privateKey: String {
        return "f21ed117490050f8c23fef496545964a98fc0ffe"
    }
    
    static var publicKey: String {
        return "9ec17fc799c3185ae79e0c1bc3d6b769"
    }
    
    static var hash: String {
        return ("\(MarvelSession.timestamp)" + privateKey + publicKey).md5
    }
    
}
