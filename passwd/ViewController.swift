//
//  ViewController.swift
//  passwd
//
//  Created by Uday on 24/01/21.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
//        print(PlistManager.load().first?.asDictionary)
        
        // to add cred to plist storage manually
//        let cred = Credential(id: UUID().uuidString, domain: "", userName: "", password: "")
//        PlistManager.write(cred: cred)
        
        
        /// to get all creds from plist storage
        /// return type - array of creds
//        let allCreds = PlistManager.load()
//        print(allCreds)
        
        let dataOfCSV = CSVManager.getCSVData()
        print(dataOfCSV)
        
    }


    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

//
//  ViewController.swift
//  TextFileCSVDemo
//
//  Created by Steven Lipton on 5/17/16.
//  Copyright © 2016 MakeAppPie.Com. All rights reserved.
//
 
import UIKit
 
class ViewController: UIViewController {
    //MARK: Outlets and properties
    var  data:[[String:String]] = []
    var  columnTitles:[String] = []
     
//    @IBOutlet weak var textView: UITextView!
     
    @IBAction func reportData(sender: UIButton) {
        printData()
    }
    @IBAction func resetData(sender: UIButton) {
//        textView.text = "Nope, no Pizza here"
    }
    @IBAction func readData(sender: UIButton) {
//        textView.text = readDataFromFile(file: "data")
    }
    @IBAction func writeData(sender: UIButton) {
        if writeDataToFile(file: "test") {
            print("data written")
        } else {
            print("data not written")
        }
    }
    //MARK: - Instance methods
     
    //MARK: CSV Functions
    func cleanRows(file:String)->String{
        //use a uniform \n for end of lines.
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
     
    func getStringFieldsForRow(row:String, delimiter:String)-> [String]{
        return row.components(separatedBy:delimiter)
    }
  
    func convertCSV(file:String){
        let rows = cleanRows(file: file).components(separatedBy:"\n")
        if rows.count > 0 {
            data = []
            columnTitles = getStringFieldsForRow(row: rows.first!,delimiter:",")
            for row in rows{
                let fields = getStringFieldsForRow(row: row,delimiter: ",")
                if fields.count != columnTitles.count {continue}
                var dataRow = [String:String]()
                for (index,field) in fields.enumerated(){
                    dataRow[columnTitles[index]] = field
                }
                data += [dataRow]
            }
        } else {
            print("No data in file")
        }
    }
     
    func printData(){
        convertCSV(file: "uday, babariya")
        var tableString = ""
        var rowString = ""
        print("data: \(data)")
        for row in data{
            rowString = ""
            for fieldName in columnTitles{
                guard let field = row[fieldName] else{
                    print("field not found: \(fieldName)")
                    continue
                }
                rowString += field + "\t"
            }
            tableString += rowString + "\n"
        }
//        textView.text = tableString
        print(tableString)
    }
     
    //MARK: Data reading and writing functions
    func writeDataToFile(file:String)-> Bool{
        // check our data exists
        let data = "abcccccccc"
        //get the file path for the file in the bundle
        // if it doesnt exist, make it in the bundle
        var fileName = file + ".txt"
        if let filePath = Bundle.main.path(forResource: file, ofType: "txt"){
            fileName = filePath
        } else {
            fileName = Bundle.main.bundlePath + fileName
        }
         
        //write the file, return true if it works, false otherwise.
        do{
            try data.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8 )
            return true
        } catch{
            return false
        }
    }
     
    func readDataFromFile(file:String)-> String!{
        let path = Bundle.main.path(forResource: "test", ofType: "txt") // file path for file "data.txt"
        let string = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        print(string)
        
        
        let bundle = Bundle.main
        if let path = bundle.path(forResource: file, ofType: "txt"){
        
            let txt = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
            print(txt)
        }

      // prints the content of data.txt
//        guard let filepath = Bundle.main.path(forResource: file, ofType: "txt") else {
//                return nil
//        }
//        do {
//            let contents = try String(contentsOf: URL(string: filepath)!, encoding: String.Encoding.utf8)
//            return contents
//        } catch {
//            print ("File Read Error")
//            return nil
//        }
//
        
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//            let fileURL = dir.appendingPathComponent(file)
//            let text = "some text"
//            //writing
//            do {
//                try text.write(to: fileURL, atomically: false, encoding: .utf8)
//            }
//            catch {/* error handling here */}
//
//            //reading
//            do {
//                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//            }
//            catch {/* error handling here */}
//        }
        return  ""
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        writeDataToFile(file: "test")
        let a = readDataFromFile(file: "test")
        print(a)
    }
 
 
}

