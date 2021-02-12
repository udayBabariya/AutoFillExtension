//
//  AddPasswordViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class AddPasswordViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectNameButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButtonAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectNameButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func showPasswordButtonAction(_ sender: UIButton){
        
    }

}
