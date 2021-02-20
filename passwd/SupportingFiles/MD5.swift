//
//  MD5.swift
//  WhiteHax PasswordManager
//
//  Created by Uday on 20/02/21.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

///MD5 encription
class MD5 {
    
    private static let salt = "IronSDN"
    private static let fixedString = "WhiteHaxMobileApp"
    
    private class func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)
        
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    /// used to get MD5 hash string of 32 Byte with salt
    open class func generateMD5(string: String) -> String{
        let inputString = salt + string + fixedString
        let md5Data = MD5(string:inputString)
        return md5Data.map { String(format: "%02hhx", $0) }.joined()
    }
}
