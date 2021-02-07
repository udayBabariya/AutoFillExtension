//
//  ViewController.swift
//  passwd
//
//  Created by Uday on 24/01/21.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    var isFirstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

//        print(PlistManager.load().first?.asDictionary)

        // to add cred to plist storage manually
//        let cred = Credential(id: UUID().uuidString, domain: "", userName: "", password: "")
//        PlistManager.write(cred: cred)
    }
     

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

extension ViewController: DocumentDelegate{
    /// callback from the document picker
        func didPickDocument(document: Document?) {
            if let pickedDoc = document {
                let fileURL = pickedDoc.fileURL
                print(fileURL)
                /// do what you want with the file URL
            }
        }
}

extension ViewController: UIDocumentPickerDelegate {
  
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard controller.documentPickerMode == .import, let url = urls.first else { return }
        if let strData = try? String(contentsOf: url) {
//            CSVManager.printData(file: strData)
            let creds = CSVManager.createCredsFromCSV(file: strData)
            print(creds)
//            for cred in creds{
//                PlistManager.write(cred: cred)
//            }
        }
        controller.dismiss(animated: true)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}
