//
//  ViewController.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 22/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.callService()
    
    }
    
    // MARK: - Service calls
    func callService() {
        APIManager
            .shared
            .request(service: MarvelService.getCharacters(),
                     completion: { value in
                        let respObject = GetCharactersResponse(JSON: value)
                        
                    })
    }
}
