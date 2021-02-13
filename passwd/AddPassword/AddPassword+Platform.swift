//
//  AddPassword+Platform.swift
//  passwd
//
//  Created by Uday on 13/02/21.
//

import UIKit

//MARK:- platform options
extension AddPasswordViewController{
    
    ///show list of available platforms
    func showAvaliableOptions(){
        let actionSheet = UIAlertController(title: "Select Platform", message: "", preferredStyle: .actionSheet)
        
        for platform in Platforms.allCases{
            let action = UIAlertAction(title: platform.rawValue, style: .default) { _ in
                self.selectedPlatform = platform
                self.selectedPlatformLabel.text = platform.rawValue
            }
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ action in }
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true)
    }
}
