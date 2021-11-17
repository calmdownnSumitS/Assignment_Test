//
//  HomeTableViewCell.swift
//  AssignmentOne
//
//  Created by JustMac on 15/11/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageDisplay : UIImageView!
    @IBOutlet weak var countriesName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
