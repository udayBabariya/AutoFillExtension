//
//  AddCredsViewController.swift
//  credProvider
//
//  Created by Uday on 29/01/21.
//

import UIKit

protocol addCredVCDelegate{
    func credAdded()
}

class AddCredsViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var delegate: addCredVCDelegate?

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
            let newCred = Credential(userName: username, password: pass)
            PlistManager.write(cred: newCred)
        }else{
            print("username or password not found")
        }
        delegate?.credAdded()
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton){
        self.dismiss(animated: true)
    }
}
