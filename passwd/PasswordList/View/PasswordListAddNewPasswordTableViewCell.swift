//
//  PasswordListAddNewPasswordTableViewCell.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class PasswordListAddNewPasswordTableViewCell: UITableViewCell {
    
    var addNewPasswordButtonAction: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addNewPasswordButtonAction(_ sender: UIButton){
        addNewPasswordButtonAction?()
    }

}
