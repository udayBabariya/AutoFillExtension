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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTableView.delegate = self
        passwordTableView.dataSource = self
    }
    
    @IBAction func exportButtonAction(_ sender: UIButton){
        
    }
    
    @IBAction func importButtonAction(_ sender: UIButton){
        
    }
    
    func navigateToAddNewPassword(){
        
    }
    
    func navigateToPasswordDetail(){
        
    }

}

//MARK:- tableView Delegate_DataSoutce
extension PasswordListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        navigateToPasswordDetail()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
