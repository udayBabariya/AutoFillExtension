//
//  LoginViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var biometricSwitch: UISwitch!
    @IBOutlet weak var enableBiometricButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        userNameTextField.layer.cornerRadius = userNameTextField.frame.height/2
        userNameTextField.layer.borderWidth = 0.8
        userNameTextField.layer.borderColor = UIColor.appBlue.cgColor
        userNameTextField.addLeftImage(image: "")
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height/2
        passwordTextField.layer.borderWidth = 0.8
        passwordTextField.layer.borderColor = UIColor.appBlue.cgColor
        passwordTextField.addLeftImage(image: "")
        passwordTextField.setRightPaddingPoints(30)
        
        
        loginButton.layer.cornerRadius      = loginButton.frame.height/2
        registerButton.layer.cornerRadius   = registerButton.frame.height/2
        registerButton.layer.borderWidth    = 0.8
        registerButton.layer.borderColor    = UIColor.appBlue.cgColor
        
    }
    
    
    @IBAction func loginButtonAction(_ sender: UIButton){
        self.dismiss(animated: true)
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func forgetPasswordButtonAction(_ sender: UIButton){
        
    }

}

//MARK: - navigation
extension LoginViewController{
    
}
