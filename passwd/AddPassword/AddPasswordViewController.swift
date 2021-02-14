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

class AddPasswordViewController: BaseViewController {
    
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
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
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
        if userNameTextField.text == "" {
            Helper.showAlert(head: "Oops!", message: "please enter username", vc: self)
            return
        }
        
        if passwordTextFiled.text == "" {
            Helper.showAlert(head: "Oops!", message: "please enter password", vc: self)
            return
        }
        
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
        passwordTextFiled.isSecureTextEntry = !passwordTextFiled.isSecureTextEntry
    }    

}

//MARK:- keyboard
extension AddPasswordViewController{
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWasShown(_ notification: Foundation.Notification){
        //Need to calculate keyboard exact size due to Apple suggestions
        let info : NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize!.height, right: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: Foundation.Notification){
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
            self.view.layoutIfNeeded()
        }
    }
}
