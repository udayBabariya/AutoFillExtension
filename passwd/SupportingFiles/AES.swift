//
//  AES.swift
//  passwd
//
//  Created by Uday on 04/02/21.
//

import Foundation
import CommonCrypto

struct AES {

    // MARK: - Value
    // MARK: Private
    private let key: Data
    private let iv: Data
    
//    static let password = "UserPassword1!"
//    static let key128   = "codingaffairscom"                   // 16 bytes for AES128
    static let key256   = "12345678901234561234567890123499"   // 32 bytes for AES256
    static let iv       = "abcdefghijklmnop"
    
//    private static final byte[] keyValue =  new byte[]{-83, 83, -29, 58, 16, 104, 117, 122, 45, -114, 36, -68, -79, -78, 59, -118, -30, -98, -106, 82, -108, -34, 117, 27, 111, -82, 86, 90, 27, 22, 46, 35};

   

    // MARK: - Initialzier
    init?(key: String, iv: String) {
        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256, let keyData = key.data(using: .utf8) else {
            debugPrint("Error: Failed to set a key.")
            return nil
        }

        guard iv.count == kCCBlockSizeAES128, let ivData = iv.data(using: .utf8) else {
            debugPrint("Error: Failed to set an initial vector.")
            return nil
        }


        self.key = keyData
        self.iv  = ivData
    }


    // MARK: - Function
    // MARK: Public
    func encrypt(string: String) -> Data? {
        return crypt(data: string.data(using: .utf8), option: CCOperation(kCCEncrypt))
    }

    func decrypt(data: Data?) -> String? {
        guard let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt)) else { return nil }
        return String(bytes: decryptedData, encoding: .utf8)
    }

    func crypt(data: Data?, option: CCOperation) -> Data? {
        guard let data = data else { return nil }

        let cryptLength = data.count + kCCBlockSizeAES128
        var cryptData   = Data(count: cryptLength)

        let keyLength = key.count
        let options   = CCOptions(kCCOptionPKCS7Padding)

        var bytesLength = Int(0)

        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                    CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes.baseAddress, keyLength, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                    }
                }
            }
        }

        guard UInt32(status) == UInt32(kCCSuccess) else {
            debugPrint("Error: Failed to crypt data. Status \(status)")
            return nil
        }

        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
    
    static func encryptWithBase64(string: String) -> String{
        let aes256 = AES(key: AES.key256, iv: AES.iv)
        if let encryptedPassword256 = aes256?.encrypt(string: string){
            let base64Data = encryptedPassword256.base64EncodedData(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
            return String(data: base64Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
        }
        return ""
    }
    
//    static func encryptWithBase64128(string: String) -> String{
//        let aes128 = AES(key: AES.key128, iv: AES.iv)
//        if let encryptedPassword128 = aes128?.encrypt(string: string){
//            let base64Data = encryptedPassword128.base64EncodedData(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
//            return String(data: base64Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
//        }
//        return ""
//    }
    
    static func decryptWithBase64(string: String)->String{
        let aes256 = AES(key: AES.key256, iv: AES.iv)
        let myData = string.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64DecodedData = Data(base64Encoded: myData)
        if let decryptedString = aes256?.decrypt(data: base64DecodedData){
          return decryptedString
        }
        return ""
    }
    
//    static func decryptWithBase64128(string: String)->String{
//        let aes128 = AES(key: AES.key128, iv: AES.iv)
//        let myData = string.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//        let base64DecodedData = Data(base64Encoded: myData)
//        if let decryptedString = aes128?.decrypt(data: base64DecodedData){
//          return decryptedString
//        }
//        return ""
//    }
}
/*
 let aes128 = AES(key: key128, iv: iv)
 let aes256 = AES(key: key256, iv: iv)

 let encryptedPassword128 = aes128?.encrypt(string: password)
 aes128?.decrypt(data: encryptedPassword128)

 let encryptedPassword256 = aes256?.encrypt(string: password)
 aes256?.decrypt(data: encryptedPassword256)
 */
