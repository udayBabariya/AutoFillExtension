//
//  ViewController.swift
//  passwd
//
//  Created by Uday on 24/01/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        print(PlistManager.load().first?.asDictionary)
        
        // to add cred to plist storage manually
//        let cred = Credential(userName: "userName", password: "Password")
//        PlistManager.write(cred: cred)
        
        
        /// to get all creds from plist storage
        /// return type - array of creds
        let allCreds = PlistManager.load()
        print(allCreds)
        
    }


    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

