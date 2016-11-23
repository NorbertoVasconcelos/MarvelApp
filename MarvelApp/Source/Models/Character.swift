//
//  Character.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 23/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import UIKit
import ObjectMapper

struct Character: Mappable {

    var id: String?
    var name: String?
    var description: String?
    var modified: Date?
    var resourceURI: String?
    // Finish these
    var urls: [Any]?
    var thumbnail: [Any]?
    var comics: [Any]?
    var stories: [Any]?
    var events: [Any]?
    var series: [Any]?
    

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        modified <- map["modified"]
        resourceURI <- map["resourceURI"]
        urls <- map["urls"]
        thumbnail <- map["thumbnail"]
        comics <- map["comics"]
        stories <- map["stories"]
        events <- map["events"]
        series <- map["series"]
    }
}
