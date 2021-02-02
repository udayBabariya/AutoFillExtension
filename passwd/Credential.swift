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
    
    var asDictionary : String {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
          guard let label = label else { return nil }
          return (label, value)
        }).compactMap { $0 })
        return dict.jsonString
      }
}


class PlistManager{
    
    static let fileName = "paswords"
    static let fileType = "plist"
    
    static private var plistUrl: URL{
        let fileManager = FileManager.default
        let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "com.uday.passwd")!
        return directory.appendingPathComponent("\(fileName)" + "." + "\(fileType)")
    }
    
    
    public static func load() -> [Credential]{
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
    
    public static func write(cred: Credential){
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


extension Dictionary {

    var jsonString:String {

        do {
            let stringData = try JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
            if let string = String(data: stringData, encoding: .utf8) {
                return string
            }
        }catch _ {

        }
        return ""
    }
}
