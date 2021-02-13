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
    }
    
    func setUp(){
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
    
}
