//
//  AddPasswordViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

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
        
    }
    
    @IBAction func showPasswordButtonAction(_ sender: UIButton){
        
    }
    
    
    
    func showAvaliableOptions(){
        let actionSheet = UIAlertController(title: "Select Platform", message: "", preferredStyle: .actionSheet)
        let facebookAction = UIAlertAction(title: "Facebook", style: .default) { (action) in
            //facebook selected
            self.selectedPlatformLabel.text = "Facebook"
        }
        let gmailAction = UIAlertAction(title: "Gmail", style: .default) { (action) in
            //gmail selected
            self.selectedPlatformLabel.text = "Gmail"
        }
        let instagramAction = UIAlertAction(title: "Instagram", style: .default) { (action) in
            //instagram selected
            self.selectedPlatformLabel.text = "Instagram"
        }
        let snapChatAction = UIAlertAction(title: "SnapChat", style: .default) { (action) in
            //snapChat selected
            self.selectedPlatformLabel.text = "SnapChat"
        }
        let linkedInAction = UIAlertAction(title: "LinkedIn", style: .default) { (action) in
            //linkedIn selected
            self.selectedPlatformLabel.text = "LinkedIn"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ action in }
        
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(gmailAction)
        actionSheet.addAction(instagramAction)
        actionSheet.addAction(snapChatAction)
        actionSheet.addAction(linkedInAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true)
    }

}
