//
//  AddPasswordViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

protocol addPasswordVCDelegate{
    func credAdded()
}

class AddPasswordViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectNameButton: UIButton!
    @IBOutlet weak var selectedPlatformLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    var delegate: addPasswordVCDelegate?
    var selectedPlatform = Platforms.Facebook

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUp(){
        saveButton.layer.cornerRadius = saveButton.frame.height/2
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectNameButtonAction(_ sender: UIButton){
        showAvaliableOptions()
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton){
        saveButton.isUserInteractionEnabled = false
        if let username = userNameTextField.text, let pass = passwordTextFiled.text{
            let newCred = Credential(id: UUID().uuidString, domain: selectedPlatform.url, userName: username, password: AES.encryptWithBase64(string: pass),platform: selectedPlatform.rawValue)
            PlistManager.write(cred: newCred)
        }else{
            print("username or password not found")
        }
        delegate?.credAdded()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showPasswordButtonAction(_ sender: UIButton){
        
    }    

}
