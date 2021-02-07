//
//  CredentialProviderViewController.swift
//  credProvider
//
//  Created by Uday on 29/01/21.
//

import UIKit
import AuthenticationServices
import MobileCoreServices

class CredentialProviderViewController: ASCredentialProviderViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var passwords = [Credential]()
     
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
        passwords = PlistManager.load() ?? [Credential]()
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }

   
    @IBAction func addCredButtonAction(_ sender: UIButton){
        guard let addCredVC = storyboard?.instantiateViewController(identifier: "AddCredsViewController") as? AddCredsViewController else {return}
        addCredVC.delegate = self
       present(addCredVC, animated: true)
    }
    
    @IBAction func deleteAllButtonAction(_ sender: UIButton){
        PlistManager.removeAll()
        fetchPasswords_ReloadTV()
    }
    
    
    @IBAction func shareCSVAction(_ sender: UIButton){
        if let allCreds = PlistManager.load(), allCreds.count > 0{
            if let localUrl = CSVManager.creatCSV(creds: allCreds){
                shareCsv(fileURL: localUrl)
            }
        }
    }
    
    @IBAction func importCSVButtonAction(){
        openDocumentPicker()
    }
    
    func fetchPasswords_ReloadTV(){
        passwords = PlistManager.load() ?? [Credential]()
        tableView.reloadData()
    }
}



extension CredentialProviderViewController: addCredVCDelegate{
    func credAdded() {
        fetchPasswords_ReloadTV()
    }
}



