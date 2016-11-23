//
//  MarvelData.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 23/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import Foundation
import ObjectMapper

struct MarvelData: Mappable {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Character]?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        offset <- map["offset"]
        limit <- map["limit"]
        total <- map["total"]
        count <- map["count"]
        results <- map["results"]
    }
}
