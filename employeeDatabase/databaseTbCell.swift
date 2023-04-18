//
//  databaseTbCell.swift
//  employeeDatabase
//
//  Created by apple on 17/04/23.
//

import UIKit

class databaseTbCell: UITableViewCell {

    @IBOutlet weak var empEmailIdLbl: UILabel!
    @IBOutlet weak var empLastNameLbl: UILabel!
    @IBOutlet weak var empFirstNameLbl: UILabel!
    @IBOutlet weak var empAvatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
