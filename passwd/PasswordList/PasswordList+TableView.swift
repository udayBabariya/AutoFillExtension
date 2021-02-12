//
//  PasswordList+TableView.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit


//MARK:- tableView Delegate_DataSoutce
extension PasswordListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastIndex = passwords.count
        if indexPath.row == lastIndex{
            guard let addNewPasswordCell = tableView.dequeueReusableCell(withIdentifier: "PasswordListAddNewPasswordTableViewCell", for: indexPath) as? PasswordListAddNewPasswordTableViewCell else {return UITableViewCell()}
            addNewPasswordCell.addNewPasswordButtonAction = { [weak self] in
                self?.navigateToAddNewPassword()
            }
            return addNewPasswordCell
        }else{
            guard let passwordCell = tableView.dequeueReusableCell(withIdentifier: "PasswordListTableViewCell", for: indexPath) as? PasswordListTableViewCell else {return UITableViewCell()}
            let tempPassword = passwords[indexPath.row]
            passwordCell.titleLabel.text = tempPassword.userName
            passwordCell.cellClicked = { [weak self] in
                self?.navigateToPasswordDetail(cred: tempPassword)
            }
            return passwordCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
