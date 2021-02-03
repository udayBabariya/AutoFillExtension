//
//  CredentialProviderViewController.swift
//  credProvider
//
//  Created by Uday on 29/01/21.
//

import UIKit
import AuthenticationServices

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
        let passwordCredential = ASPasswordCredential(user: cred.userName, password: cred.password)
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            PlistManager.delete(cred: passwords[indexPath.row])
            fetchPasswords_ReloadTV()
        }
    }
}

///TableView cell for creds
class Cell: UITableViewCell{
    override  func awakeFromNib() {
    }
}


