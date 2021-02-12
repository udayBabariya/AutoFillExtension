//
//  PasswordListTableViewCell.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class PasswordListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    var cellClicked: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func cellButtonClicked(_ sender: UIButton){
        cellClicked?()
    }

}
