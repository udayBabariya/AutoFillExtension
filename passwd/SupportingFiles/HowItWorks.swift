//
//  HowItWorks.swift
//  WhiteHax PasswordManager
//
//  Created by Uday on 22/02/21.
//

/*
 
 1 - save user name in local storage (UserDefaults)
 2 - Define salt and fixed string for MD5 key generation
         let salt = "IronSDN"
         let fixedString = "WhiteHaxMobileApp"
 3 - create inputString as below:
        let inputString = salt + string + fixedString
 4 - use that fixed string for input of MD5 and generate 32 byte key for AES256Key
 5 -  encrypt password  by AES256 (with AES256Key and iv ="abcdefghijklmnop") before storing to local database
 
 */
