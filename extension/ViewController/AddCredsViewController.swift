//
//  AddCredsViewController.swift
//  passwd
//
//  Created by Uday on 26/01/21.
//

import UIKit

class AddCredsViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addButton.isUserInteractionEnabled = true
    }
    
    @IBAction func addButtonAction(_ sender: UIButton){
        addButton.isUserInteractionEnabled = false
        if let username = userNameTextField.text, let pass = passwordTextField.text{
            let newCred = Credential(username: username, password: pass)
            RealmAPI.shared.write(data: newCred)
        }else{
            print("username or password not found")
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton){
        self.dismiss(animated: true)
    }
}
