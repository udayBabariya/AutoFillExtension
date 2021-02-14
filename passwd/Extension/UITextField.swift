//
//  UITextField.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

extension UITextField{
    
    /// to add left side image of textfield
    func addLeftImage(image: String, tintColor: UIColor? = nil) {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let lftImgView = UIImageView(image: UIImage(named: image))
        if let tintColor = tintColor{
            lftImgView.tintColor = tintColor
        }
        lftImgView.frame = CGRect(x: 5, y: 0, width: 30, height: 20)
        lftImgView.contentMode = .scaleAspectFit
        mainView.addSubview(lftImgView)
        mainView.isUserInteractionEnabled = false
        self.leftView = mainView
        self.leftViewMode = .always
    }
    
    ///set right side padding
    func setRightPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    ///set right side padding
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
