//
//  Helper.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class Helper{
    
    static let keyIsLoggedIn = "isLogin"
    
    class func isLogedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: keyIsLoggedIn)
    }
    
    class func setLoginState(login: Bool){
        UserDefaults.standard.setValue(login, forKey: keyIsLoggedIn)
    }
    
    
    class func showAlert(head:String, message:String, vc: UIViewController ) {
        
        let alert = UIAlertController(title: head, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}

///right side logo of url - by default show key
///custom platform + blank url
///edit password - url + platform editable
///show password button
///after import platform missing
///logout button on top right corner
///liteuser1 - whitehax123 default pass

//DONE
///home top bar - add logo
///SplashScreen
///APP iCON
