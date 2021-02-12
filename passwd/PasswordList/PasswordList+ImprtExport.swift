//
//  PasswordList+ImprtExport.swift
//  passwd
//
//  Created by Uday on 12/02/21.
//

import UIKit
import MobileCoreServices

//MARK:- improt export functions
extension PasswordListViewController: UIDocumentPickerDelegate {
    
    func openDocumentPicker(){
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText)], in: .import)
           documentPicker.delegate = self
           documentPicker.allowsMultipleSelection = false
           documentPicker.modalPresentationStyle = .fullScreen
           present(documentPicker, animated: true, completion: nil)
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard controller.documentPickerMode == .import, let url = urls.first else { return }
        if let strData = try? String(contentsOf: url) {
            if let creds = CSVManager.createCredsFromCSV(file: strData) {
                for cred in creds{
                    if isCredAlredyExist(cred: cred) {continue}
                    PlistManager.write(cred: cred)
                    fetchPasswords_ReloadTV()
                }
            }
        }
        controller.dismiss(animated: true)
    }
    
    ///check if same credential is already exist in plist file
    private func isCredAlredyExist(cred: Credential) -> Bool{
        for existingCred in passwords{
            if cred.id == existingCred.id{
                return true
            }
        }
        return false
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
    
    
    ///ecport CSV file
    func shareCsv(fileURL: URL){
        let objectsToShare = [fileURL]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
}
