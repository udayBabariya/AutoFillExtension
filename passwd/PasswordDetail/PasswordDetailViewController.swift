//
//  PasswordDetailViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class PasswordDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBarTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var urlLable: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func showPasswordButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton){
        
    }
    
}
