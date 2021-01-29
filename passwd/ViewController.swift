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
        
        /// to add cred to plist storage
//        let cred = Credential(userName: "a", password: "a")
//        PlistLoader.write(cred: cred)

    }


    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

