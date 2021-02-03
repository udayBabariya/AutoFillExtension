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
    
    static let fileName = "pass"
    static let fileType = "plist"
    
    static private var plistUrl: URL{
        let fileManager = FileManager.default
        let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "com.uday.passwd")!
        return directory.appendingPathComponent("\(fileName)" + "." + "\(fileType)")
    }
    
    /// create local storage file if needed
    static private func createPlistFileIfNeeded(){
        if !FileManager.default.fileExists(atPath: PlistManager.plistUrl.path){
            let creds = [Credential(userName: "", password: "")]
            if let dataToWrite = try? PropertyListEncoder().encode(creds){
                try? dataToWrite.write(to: PlistManager.plistUrl)
                PlistManager.removeAll()
            }
        }
    }
    
    
    /// to get all stored creds
    public static func load() -> [Credential]?{
        let decoder = PropertyListDecoder()
        createPlistFileIfNeeded()
        guard let data = try? Data.init(contentsOf: plistUrl),
              let creds = try? decoder.decode([Credential].self, from: data)
        else {return nil}
        
        return creds
    }
    
   
    /// to save new creds in local storage
    public static func write(cred: Credential){
        let encoder = PropertyListEncoder()
        var creds = [Credential]()
        createPlistFileIfNeeded()
        let decoder = PropertyListDecoder()
        
        if let existingData = try? Data.init(contentsOf: plistUrl){
            if let tempCreds = try? decoder.decode([Credential].self, from: existingData){
                creds.append(contentsOf: tempCreds)
                creds.append(cred)
            }else{
                creds.append(cred)
                print("file is empty")
            }
        }
        
        if let dataToWrite = try? encoder.encode(creds){
            // Save to plist
            try? dataToWrite.write(to: plistUrl)
        }
    }
    
    ///to delete credential from plistDatabase
    public static func delete(cred: Credential){
        
        let decoder = PropertyListDecoder()
        
        if let data = try? Data.init(contentsOf: plistUrl),
              var creds = try? decoder.decode([Credential].self, from: data){
            for (i,tempCred) in creds.enumerated(){
                if tempCred.userName == cred.userName && tempCred.password == cred.password{
                    creds.remove(at: i)
                    break
                }
            }
            if let dataToWrite = try? PropertyListEncoder().encode(creds){
                // Save to plist
                try? dataToWrite.write(to: plistUrl)
            }
        }
    }
    
    ///to remove all creds stored in database
    public static func removeAll(){
        let decoder = PropertyListDecoder()
        
        if let data = try? Data.init(contentsOf: plistUrl),
              var creds = try? decoder.decode([Credential].self, from: data){
            creds.removeAll()
            if let dataToWrite = try? PropertyListEncoder().encode(creds){
                // Save to plist
                try? dataToWrite.write(to: plistUrl)
            }
        }
    }
    
    
}


//used to convert string JSON from Dictionary
extension Dictionary {
    var jsonString:String {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        guard jsonData != nil else {return ""}
        let jsonString = String(data: jsonData!, encoding: .utf8)
        guard jsonString != nil else {return ""}
        return jsonString!
    }
}
