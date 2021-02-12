//
//  Helper.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import Foundation

class Helper{
    
    static let keyIsLoggedIn = "isLogin"
    
    class func isLogedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: keyIsLoggedIn)
    }
    
    class func setLoginState(login: Bool){
        UserDefaults.standard.setValue(login, forKey: keyIsLoggedIn)
    }
}
