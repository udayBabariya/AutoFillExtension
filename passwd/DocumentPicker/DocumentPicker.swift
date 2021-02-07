//
//  DocumentPicker.swift
//  passwd
//
//  Created by Uday on 07/02/21.
//

import UIKit
import MobileCoreServices

protocol DocumentDelegate: class {
    func didPickDocument(document: Document?)
}

class Document: UIDocument {
    var data: Data?
    override func contents(forType typeName: String) throws -> Any {
        guard let data = data else { return Data() }
        return try NSKeyedArchiver.archivedData(withRootObject:data,
                                                requiringSecureCoding: true)
    }
    override func load(fromContents contents: Any, ofType typeName:
        String?) throws {
        guard let data = contents as? Data else { return }
        self.data = data
    }
}

open class DocumentPicker: NSObject {
    private var pickerController: UIDocumentPickerViewController?
    private weak var presentationController: UIViewController?
    private weak var delegate: DocumentDelegate?

    private var pickedDocument: Document?

    init(presentationController: UIViewController, delegate: DocumentDelegate) {
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
    }

    public func displayPicker() {
        
        /// pick movies and images
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet,kUTTypeUTF8PlainText]
        self.pickerController = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        self.pickerController!.delegate = self
        self.presentationController?.present(self.pickerController!, animated: true)
    }
}

extension DocumentPicker: UIDocumentPickerDelegate {

    /// delegate method, when the user selects a file
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        documentFromURL(pickedURL: url)
        delegate?.didPickDocument(document: pickedDocument)
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        // Start accessing a security-scoped resource.
        guard url.startAccessingSecurityScopedResource() else {
            // Handle the failure here.
            return
        }

        // Make sure you release the security-scoped resource when you are done.
        defer { url.stopAccessingSecurityScopedResource() }

        // Use file coordination for reading and writing any of the URL’s content.
        var error: NSError? = nil
        NSFileCoordinator().coordinate(readingItemAt: url, error: &error) { (url) in
                
            let keys : [URLResourceKey] = [.nameKey, .isDirectoryKey]
                
            // Get an enumerator for the directory's content.
            guard let fileList =
                FileManager.default.enumerator(at: url, includingPropertiesForKeys: keys) else {
                Swift.debugPrint("*** Unable to access the contents of \(url.path) ***\n")
                return
            }
                
            for case let file as URL in fileList {
                // Also start accessing the content's security-scoped URL.
                guard url.startAccessingSecurityScopedResource() else {
                    // Handle the failure here.
                    continue
                }

                // Do something with the file here.
                Swift.debugPrint("chosen file: \(file.lastPathComponent)")
                    
                // Make sure you release the security-scoped resource when you are done.
                url.stopAccessingSecurityScopedResource()
            }
        }
    }

    /// delegate method, when the user cancels
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        delegate?.didPickDocument(document: nil)
    }

    private func documentFromURL(pickedURL: URL) {
        
        /// start accessing the resource
        let shouldStopAccessing = pickedURL.startAccessingSecurityScopedResource()

        defer {
            if shouldStopAccessing {
                pickedURL.stopAccessingSecurityScopedResource()
            }
        }
        NSFileCoordinator().coordinate(readingItemAt: pickedURL, error: NSErrorPointer.none) { (readURL) in
            let document = Document(fileURL: readURL)
            pickedDocument = document
        }
    }
}
