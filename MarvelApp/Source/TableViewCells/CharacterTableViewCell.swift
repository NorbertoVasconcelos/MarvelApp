//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Norberto Vasconcelos on 23/11/16.
//  Copyright © 2016 Norberto. All rights reserved.
//

import UIKit

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
    
}
