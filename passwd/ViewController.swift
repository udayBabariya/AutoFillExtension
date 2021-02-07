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

//        print(PlistManager.load().first?.asDictionary)

        // to add cred to plist storage manually
//        let cred = Credential(id: UUID().uuidString, domain: "", userName: "", password: "")
//        PlistManager.write(cred: cred)


        
    }
     

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

//class ViewController: UIViewController {
//
//var creds = [Credential]()
//var cred: Credential!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //
//        //
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        cred = Credential()
//        for _ in 0..<5 {
//            cred.id = UUID().uuidString
//            cred.userName = "userName"
//            cred.password = "abc"
//            cred.domain = "www.facebook.com"
//            creds.append(cred)
//        }
//        if let path = creatCSV(){
//            shareCsv(fileURL: path)
//        }
//
//    }
//
//
//}

