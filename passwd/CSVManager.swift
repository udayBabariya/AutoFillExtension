//
//  CSVManager.swift
//  passwd
//
//  Created by Uday on 05/02/21.
//

import Foundation

///CSV file manager
class CSVManager{
    
    ///get gata from csv file
   public static func getCSVData() -> Array<String> {
        do {
            let content = try String(contentsOfFile: "./test.txt")
            let parsedCSV: [String] = content.components(
                separatedBy: "\n"
            ).map{ $0.components(separatedBy: ",")[0] }
            return parsedCSV
        }
        catch {
            return []
        }
    }
}
