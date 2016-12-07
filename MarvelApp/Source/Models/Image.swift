//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 07/12/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import Foundation
import ObjectMapper

enum ImageType:String {
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitXlarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"
}

struct Image: Mappable {
    
    var path: String?
    var imageExtension: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        path <- map["path"]
        imageExtension <- map["extension"]
    }
    
    func pathForType(type:ImageType) -> String {
        return (path ?? "") + "/" + type.rawValue + "." + (imageExtension ?? ".jpg")
    }
}
