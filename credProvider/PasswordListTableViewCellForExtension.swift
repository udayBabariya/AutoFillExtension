//
//  PasswordListTableViewCell.swift
//  credProvider
//
//  Created by Uday on 14/02/21.
//

import UIKit

class PasswordListTableViewCellForExtension: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setPlatformImage(platform: String){
        let tempPlatForm = Platforms.init(rawValue: platform) ?? .Facebook
        
        switch tempPlatForm{
        case .Facebook:
            platformImageView.image = UIImage(named: "facebook")
        case .Gmail:
            platformImageView.image = UIImage(named: "gmail")
        case .SnapChat:
            platformImageView.image = UIImage(named: "snapchat")
        case .Instagram:
            platformImageView.image = UIImage(named: "instagram")
        case .LinkedIn:
            platformImageView.image = UIImage(named: "linkedin")
        case .custom:
            platformImageView.image = UIImage(named: "password")
        }
    }


}
