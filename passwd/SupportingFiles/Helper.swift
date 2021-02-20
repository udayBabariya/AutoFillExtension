//
//  Helper.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class Helper{
    
    static let keyIsLoggedIn    = "isLogin"
    static let userName         = "userName"
    static let appGroup         = "group.pwUdayDemo"
    
    class func isLogedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Helper.keyIsLoggedIn)
    }
    
    class func setLoginState(login: Bool){
        UserDefaults.standard.setValue(login, forKey: Helper.keyIsLoggedIn)
        UserDefaults.standard.synchronize()
    }
    
    class func getLoggedInUserName() -> String{
        
        let userDefaults = UserDefaults(suiteName: Helper.appGroup)
        if let userName = userDefaults?.object(forKey: Helper.userName) as? String {
          return userName
        }
        
        if let userName = UserDefaults.standard.string(forKey: Helper.userName){
            return userName
        }
        return  ""
    }
    
    class func setLoggedInUserName(userName: String){
        UserDefaults.standard.setValue(userName, forKey: Helper.userName)
        UserDefaults.standard.synchronize()
        
        let userDefaults = UserDefaults(suiteName: Helper.appGroup)!
        userDefaults.set(userName, forKey: Helper.userName)
        userDefaults.synchronize()
    }
    
    
    class func showAlert(head:String, message:String, vc: UIViewController ) {
        
        let alert = UIAlertController(title: head, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}

class StringConstant{
    
    static let defaultUser = "liteuser1"
    static let defaultPass = "whitehax123"
}





//DONE
///home top bar - add logo
///SplashScreen
///APP iCON
///home screen logo
///logout button + flow
///liteuser1 - whitehax123 default pass
///platform icon for extension
///logout button on top right corner
///show password button
///after import platform missing
///custom platform + blank url
///edit password - url + platform editable
///add button icon change on home screen
