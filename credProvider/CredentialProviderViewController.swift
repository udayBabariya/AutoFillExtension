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

    @IBAction func passwordSelected(_ sender: AnyObject?) {
        let passwordCredential = ASPasswordCredential(user: "j_appleseed", password: "apple1234")
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
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
    
    func fetchPasswords_ReloadTV(){
        passwords = PlistManager.load() ?? [Credential]()
        tableView.reloadData()
    }
    
    @IBAction func shareCSVAction(_ sender: UIButton){
        if let allCreds = PlistManager.load(){
            if let localUrl = CSVManager.creatCSV(creds: allCreds){
                shareCsv(fileURL: localUrl)
            }
        }
    }
    
    @IBAction func pickCSV(){
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText)], in: .import)
           documentPicker.delegate = self
           documentPicker.allowsMultipleSelection = false
           documentPicker.modalPresentationStyle = .fullScreen
           present(documentPicker, animated: true, completion: nil)
    }
    
    
    ///ecport CSV file
    func shareCsv(fileURL: URL){
        let objectsToShare = [fileURL]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
}



extension CredentialProviderViewController: addCredVCDelegate{
    func credAdded() {
        fetchPasswords_ReloadTV()
    }
}

//MARK: UITableView datasource, delegate
extension CredentialProviderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell else {return UITableViewCell()}
        let cred = passwords[indexPath.row]
        cell.textLabel?.text = cred.userName
        cell.detailTextLabel?.text = cred.password
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cred = passwords[indexPath.row]
        let passwordCredential = ASPasswordCredential(user: cred.userName, password: AES.decryptWithBase64(string: cred.password))
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            PlistManager.delete(cred: passwords[indexPath.row])
//            fetchPasswords_ReloadTV()
//        }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let tempCred =  passwords[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, bool) in
            PlistManager.delete(cred: tempCred)
            self.fetchPasswords_ReloadTV()
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, bool) in
            guard let addCredVC = self.storyboard?.instantiateViewController(identifier: "AddCredsViewController") as? AddCredsViewController else {return}
            addCredVC.delegate = self
            addCredVC.usedForUpdate = true
            addCredVC.cred = tempCred
            self.present(addCredVC, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [delete,edit])
    }
}

//MARK:- document picker delegate
extension CredentialProviderViewController: UIDocumentPickerDelegate {
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard controller.documentPickerMode == .import, let url = urls.first else { return }
        if let strData = try? String(contentsOf: url) {
            if let creds = CSVManager.createCredsFromCSV(file: strData) {
                for cred in creds{
                    PlistManager.write(cred: cred)
                    fetchPasswords_ReloadTV()
                }
            }
        }
        controller.dismiss(animated: true)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}

///TableView cell for creds
class Cell: UITableViewCell{
    override  func awakeFromNib() {
    }
}


