//
//  CredentialProviderViewController.swift
//  credProvider
//
//  Created by Uday on 13/02/21.
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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


//MARK: UITableView datasource, delegate
extension CredentialProviderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let passwordCell = tableView.dequeueReusableCell(withIdentifier: "PasswordListTableViewCellForExtension", for: indexPath) as? PasswordListTableViewCellForExtension else {return UITableViewCell()}
        let tempPassword = passwords[indexPath.row]
        passwordCell.titleLabel.text = tempPassword.userName
        passwordCell.setPlatformImage(platform: tempPassword.platform)
        return passwordCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cred = passwords[indexPath.row]
        let passwordCredential = ASPasswordCredential(user: cred.userName, password: AES.decryptWithBase64(string: cred.password))
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }
}
