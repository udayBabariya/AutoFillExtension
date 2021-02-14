//
//  PasswordList+Navigation.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit


//MARK: navigation
extension PasswordListViewController{
    
    ///navigate to add password screem
    func navigateToAddNewPassword(){
        guard let passwordDetailVC = UIStoryboard(name: "PasswordDetail", bundle: nil).instantiateViewController(withIdentifier: "PasswordDetailViewController") as? PasswordDetailViewController else {return}
        passwordDetailVC.delegate = self
        passwordDetailVC.usedForAddNewPassword = true
        self.navigationController?.pushViewController(passwordDetailVC, animated: true)
    }
    
    /// navigate to selected credentials details screen
    func navigateToPasswordDetail(cred: Credential){
        guard let passwordDetailVC = UIStoryboard(name: "PasswordDetail", bundle: nil).instantiateViewController(withIdentifier: "PasswordDetailViewController") as? PasswordDetailViewController else {return}
        passwordDetailVC.delegate = self
        passwordDetailVC.selectedPassword = cred
        self.navigationController?.pushViewController(passwordDetailVC, animated: true)
    }
    
    ///present login screen
    func navigateToLogin(){
        guard let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.delegate = self
        self.present(loginVC, animated: true)
    }
}

extension PasswordListViewController: loginVCDelegate{
    func login() {
        checkForLoginSetData()
    }
}


//MARK:- Delegate
extension PasswordListViewController: passwordDetailVCDelegate{
    func deleted() {
        fetchPasswords_ReloadTV()
    }
    
    func modified() {
        fetchPasswords_ReloadTV()
    }
    
    func credAdded() {
        fetchPasswords_ReloadTV()
    }
    
    
}
