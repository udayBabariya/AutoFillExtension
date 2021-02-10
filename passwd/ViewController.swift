//
//  ViewController.swift
//  passwd
//
//  Created by Uday on 24/01/21.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "login"
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
    
    @IBAction func loginButtonAction(_ sendeer: UIButton){
        print("login button action")
        navigateToHomeScreen()
    }
    
    func navigateToHomeScreen(){
        guard let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {return}
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}

class HomeViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
}
