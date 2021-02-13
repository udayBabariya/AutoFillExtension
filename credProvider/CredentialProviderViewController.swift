//
//  CredentialProviderViewController.swift
//  credProvider
//
//  Created by Uday on 29/01/21.
//

import UIKit
import AuthenticationServices
import MobileCoreServices
import os.log

class CredentialProviderViewController: ASCredentialProviderViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var passwords = [Credential]()
     
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
        NSLog("prepareCredentialList")
        os_log("%{public}@", log: OSLog(subsystem: "com.uday.passwd", category: "myExtension"), type: OSLogType.debug, "prepareCredentialListSanket")
        passwords = PlistManager.load() ?? [Credential]()
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    @IBAction func cancel(_ sender: AnyObject?) {
        print("cancel")
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }

   
    @IBAction func addCredButtonAction(_ sender: UIButton){
        NSLog("addButtonAction")
        guard let addCredVC = storyboard?.instantiateViewController(identifier: "AddCredsViewController") as? AddCredsViewController else {return}
        addCredVC.delegate = self
       present(addCredVC, animated: true)
    }
    
    @IBAction func deleteAllButtonAction(_ sender: UIButton){
        print("deleteAll")
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
    
    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
        print("provideCredentialWithoutUserInteraction")
//        print("in provider: \(credentialIdentity.recordIdentifier!)")
        let credToProvide = ASPasswordCredential(user: "udayyy", password: "paasssss")
        self.extensionContext.completeRequest(withSelectedCredential: credToProvide, completionHandler: nil)
        
//        if let allCreds = PlistManager.load(), allCreds.count > 0{
//            let filteredCreds = allCreds.filter {$0.domain == credentialIdentity.recordIdentifier!}
//            if filteredCreds.count > 0, let firstCred = filteredCreds.first{
//                let credToProvide = ASPasswordCredential(user: firstCred.userName, password: AES.decryptWithBase64(string: firstCred.password))
//                self.extensionContext.completeRequest(withSelectedCredential: credToProvide, completionHandler: nil)
//            }else{
//                self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code:ASExtensionError.userInteractionRequired.rawValue))
//            }
//        }
    }
}



extension CredentialProviderViewController: addCredVCDelegate{
    func credAdded() {
        fetchPasswords_ReloadTV()
    }
}



