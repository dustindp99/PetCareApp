//
//  PetTableViewCell.swift
//  PetCareApp
//
//  Created by Dustin on 11/27/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    {
       didSet {
        petImageView.layer.cornerRadius = petImageView.bounds.width / 2
        petImageView.clipsToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
