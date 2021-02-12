//
//  PasswordListViewController.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit

class PasswordListViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordTableView: UITableView!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    
    var passwords = [Credential]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwords = PlistManager.load() ?? [Credential]()
        passwordTableView.delegate = self
        passwordTableView.dataSource = self
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
    
    @IBAction func importButtonAction(_ sender: UIButton){
        openDocumentPicker()
    }
}

