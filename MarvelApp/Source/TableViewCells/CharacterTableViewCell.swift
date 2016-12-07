//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 23/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    
    
    // MARK: - View LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with character: Character) {
        self.lblName.text = character.name
        self.lblDescription.text = character.description
        if let url = URL(string: character.thumbnail?.pathForType(type: .portraitMedium) ?? "") {
            print(url)
//            imgPicture.kf.setImage(with:url)
            imgPicture.kf.setImage(with: url,
                                   placeholder: #imageLiteral(resourceName: "img_not_found"),
                                   options: nil,
                                   progressBlock: nil,
                                   completionHandler: nil)
        }
    }
    
}
