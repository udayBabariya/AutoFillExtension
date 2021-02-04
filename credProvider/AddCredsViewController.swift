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
    var cred = Credential()
    var usedForUpdate = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addButton.isUserInteractionEnabled = true
        if usedForUpdate{
            userNameTextField.text = cred.userName
            passwordTextField.text = AES.decryptWithBase64(string: cred.password)
            addButton.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIButton){
        addButton.isUserInteractionEnabled = false
        if let username = userNameTextField.text, let pass = passwordTextField.text{
            if  usedForUpdate{
                cred = Credential(id: cred.id, domain: cred.domain, userName: username, password: AES.encryptWithBase64(string: pass))
                PlistManager.edit(cred: cred)
            }else{
                let newCred = Credential(id: UUID().uuidString, domain: "", userName: username, password: AES.encryptWithBase64(string: pass))
                PlistManager.write(cred: newCred)
            }
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

