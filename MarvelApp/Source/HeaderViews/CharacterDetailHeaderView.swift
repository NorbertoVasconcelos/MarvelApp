//
//  CharacterDetailHeaderView.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 14/12/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import UIKit

class CharacterDetailHeaderView: UIView {

    @IBOutlet weak var image: UIImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CharacterDetailHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
