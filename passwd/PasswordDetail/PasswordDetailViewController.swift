//
//  PasswordDetailViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

protocol passwordDetailVCDelegate{
    func deleted()
    func modified()
}

class PasswordDetailViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBarTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var urlLable: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    var selectedPassword = Credential()
    var delegate: passwordDetailVCDelegate?

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
        updateButton.layer.cornerRadius = updateButton.frame.height/2
        deleteButton.layer.cornerRadius = deleteButton.frame.height/2
        serviceTypeLabel.text = selectedPassword.platform
        urlLable.text = selectedPassword.domain
        userNameTextField.text = selectedPassword.userName
        passwordTextField.text = AES.decryptWithBase64(string: selectedPassword.password)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showPasswordButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton){
        
        let alert = UIAlertController(title: "Delete", message: "Are You Sure?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            PlistManager.delete(cred: self.selectedPassword)
            self.delegate?.deleted()
            self.navigationController?.popViewController(animated: true)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true)
       
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        
        if userNameTextField.text == "" {
            Helper.showAlert(head: "Oops!", message: "please enter username", vc: self)
            return
        }
        
        if passwordTextField.text == "" {
            Helper.showAlert(head: "Oops!", message: "please enter password", vc: self)
            return
        }
        
        
        selectedPassword.userName = userNameTextField.text ?? ""
        selectedPassword.password = AES.encryptWithBase64(string: passwordTextField.text ?? "")
        
        PlistManager.edit(cred: selectedPassword)
        delegate?.modified()
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- keyboard
extension PasswordDetailViewController{
    
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

