//
//  CSVManager.swift
//  passwd
//
//  Created by Uday on 05/02/21.
//

import UIKit

///CSV file manager
class CSVManager{
    
    static var  data:[[String:String]] = []
    static var  columnTitles:[String] = []

    
    /// read csv file and get string
   public static func readDataFromFile(file:String)-> String!{
       let bundle = Bundle.main
       if let path = bundle.path(forResource: file, ofType: "txt"){
       
           let txt = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
           return txt
       }
       return  ""
   }
    
    ///convert string into comma seperated string
    public static func convertCSV(file:String){
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
    
    //MARK: CSV Functions
    static func cleanRows(file:String)->String{
        //use a uniform \n for end of lines.
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
     
    static func getStringFieldsForRow(row:String, delimiter:String)-> [String]{
        return row.components(separatedBy:delimiter)
    }
    
    ///pring data
    static func printData(file: String){
        convertCSV(file: file)
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
    
    
    // MARK: CSV file creating
    public static func creatCSV(creds: [Credential]) -> URL? {
            let fileName = "Creds.csv"
            let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
            var csvText = "id,userName,password,domain\n"

            for cred in creds {
                let newLine = "\(cred.id),\(cred.userName),\(cred.password),\(cred.domain)\n"
                csvText.append(newLine)
            }
            do {
                try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Failed to create file")
                print("\(error)")
            }
            return path
        }
    
    
    //MARK: Data reading and writing functions
    public static func writeDataToFile()-> Bool{
        // check our data exists
        let data = "abcccccccc"
        //get the file path for the file in the bundle
        // if it doesnt exist, make it in the bundle
        var fileName =   "test.txt"
        if let filePath = Bundle.main.path(forResource: "test", ofType: "txt"){
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
    
    
}
