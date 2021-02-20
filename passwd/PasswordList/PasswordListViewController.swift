//
//  PasswordListViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class PasswordListViewController: BaseViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordTableView: UITableView!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    
    var passwords = [Credential]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTableView.delegate = self
        passwordTableView.dataSource = self
        checkForLoginSetData()
    }
    
    internal func checkForLoginSetData(){
        if Helper.isLogedIn(){
            fetchPasswords_ReloadTV()
        }else{
            self.passwords.removeAll()
            passwordTableView.reloadData()
            navigateToLogin()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func exportButtonAction(_ sender: UIButton){
        if let allCreds = PlistManager.load(), allCreds.count > 0{
            if let localUrl = CSVManager.creatCSV(creds: allCreds){
                shareCsv(fileURL: localUrl)
            }
        }
    }
    
    @IBAction func logoutButtonAcion(_ sender: UIButton){
       
        
        let alert = UIAlertController(title: "Logout", message: "Are You Sure?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            Helper.setLoggedInUserName(userName: "")
            Helper.setLoginState(login: false)
            self.checkForLoginSetData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func importButtonAction(_ sender: UIButton){
        openDocumentPicker()
    }
    
    ///fetch all password from plisrt file and reload tableview
    internal func fetchPasswords_ReloadTV(){
        passwords = PlistManager.load() ?? [Credential]()
        passwordTableView.reloadData()
    }
}

