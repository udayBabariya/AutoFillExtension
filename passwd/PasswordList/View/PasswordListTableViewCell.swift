//
//  PasswordListTableViewCell.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class PasswordListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!

    var cellClicked: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func cellButtonClicked(_ sender: UIButton){
        cellClicked?()
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
        }
    }

}
