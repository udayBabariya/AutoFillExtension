//
//  LoginViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

protocol loginVCDelegate{
    func login()
}

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var biometricSwitch: UISwitch!
    @IBOutlet weak var enableBiometricButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    var delegate: loginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        userNameTextField.layer.cornerRadius = userNameTextField.frame.height/2
        userNameTextField.layer.borderWidth = 0.8
        userNameTextField.layer.borderColor = UIColor.appBlue.cgColor
//        userNameTextField.addLeftImage(image: "")
        userNameTextField.setLeftPaddingPoints(30)
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height/2
        passwordTextField.layer.borderWidth = 0.8
        passwordTextField.layer.borderColor = UIColor.appBlue.cgColor
//        passwordTextField.addLeftImage(image: "")
        passwordTextField.setLeftPaddingPoints(30)
        passwordTextField.setRightPaddingPoints(30)
        
        
        loginButton.layer.cornerRadius      = loginButton.frame.height/2
        registerButton.layer.cornerRadius   = registerButton.frame.height/2
        registerButton.layer.borderWidth    = 0.8
        registerButton.layer.borderColor    = UIColor.appBlue.cgColor
        
    }
    
    
    @IBAction func loginButtonAction(_ sender: UIButton){
//        if userNameTextField.text == ""{
//            Helper.showAlert(head: "Oops!", message: "Please Enter UserName", vc: self)
//            return
//        }
//        
//        if passwordTextField.text == ""{
//            Helper.showAlert(head: "Oops!", message: "Please Enter Password", vc: self)
//            return
//        }
//        
//        ///check for default password
//        if userNameTextField.text != StringConstant.defaultUser ||
//            passwordTextField.text != StringConstant.defaultPass{
//            Helper.showAlert(head: "Oops!", message: "Username or password invalid!", vc: self)
//            return
//        }

        
        Helper.setLoginState(login: true)
        delegate?.login()
        self.dismiss(animated: true)
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func forgetPasswordButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func showPasswordButtonAction( _sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }

}

