//
//  ViewController.swift
//  passwd
//
//  Created by Uday on 24/01/21.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    var isFirstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

//        print(PlistManager.load().first?.asDictionary)

        // to add cred to plist storage manually
//        let cred = Credential(id: UUID().uuidString, domain: "", userName: "", password: "")
//        PlistManager.write(cred: cred)
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
