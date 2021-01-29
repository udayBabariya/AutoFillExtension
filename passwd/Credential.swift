//
//  Credential.swift
//  passwd
//
//  Created by Uday on 29/01/21.
//

import UIKit
import Foundation

///Credential model
struct Credential: Codable{
    var userName = ""
    var password = ""
}


class PlistManager{
    
    static let fileName = "paswords"
    static let fileType = "plist"
    
    static private var plistUrl: URL{
        let fileManager = FileManager.default
        let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "com.uday.pass")!
        return directory.appendingPathComponent("\(fileName)" + "." + "\(fileType)")
    }
    
    
    static func load() -> [Credential]{
        let decoder = PropertyListDecoder()
        
        guard let data = try? Data.init(contentsOf: plistUrl),
              let creds = try? decoder.decode([Credential].self, from: data)
        else {return [Credential(userName: "demo", password: "demo")]}
        
        return creds
    }
    
    
    static func copyCredsFrombundle(){
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType),
           let data = FileManager.default.contents(atPath: path),
           FileManager.default.fileExists(atPath: plistUrl.path) == false {
            FileManager.default.createFile(atPath: plistUrl.path, contents: data, attributes: nil)
        }
    }
    
    static func write(cred: Credential){
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode([cred]){
            if !FileManager.default.fileExists(atPath: plistUrl.path){
                FileManager.default.createFile(atPath: plistUrl.path, contents: data, attributes: nil)
            }else{
            
                let decoder = PropertyListDecoder()
                if let existingData = try? Data.init(contentsOf: plistUrl),
                   var creds = try? decoder.decode([Credential].self, from: existingData){
                    creds.append(cred)
                    
                    if let dataToWrite = try? encoder.encode(creds){
                        // Save to plist
                        try? dataToWrite.write(to: plistUrl)
                    }
                }
            }
        }
    }
}
