//
//  APIManager.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 23/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import Foundation
import Alamofire

public class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func request(service: MarvelService, completion: @escaping ([String: AnyObject]) -> ()) {
        Alamofire
            .request(service.requestURL,
                     parameters: service.parameters)
            .responseJSON { response in
                
                if let value = response.result.value as? [String: AnyObject] {
                    completion(value)
                }
            }
    }
    
}
