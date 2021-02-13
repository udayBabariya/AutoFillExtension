//
//  CredProvider+TV.swift
//  credProvider
//
//  Created by Uday on 07/02/21.
//

import UIKit
import AuthenticationServices

//MARK: UITableView datasource, delegate
extension CredentialProviderViewController2: UITableViewDelegate, UITableViewDataSource{
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

///TableView cell for creds
class Cell: UITableViewCell{
    override  func awakeFromNib() {
    }
}


