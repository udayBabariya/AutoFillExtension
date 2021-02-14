//
//  PlatformOptions.swift
//  passwd
//
//  Created by Uday on 13/02/21.
//

import Foundation


enum Platforms: String, CaseIterable{
    
    case Facebook
    case Gmail
    case SnapChat
    case Instagram
    case LinkedIn
    case custom
    
    var url: String {
        switch self{
        case .Facebook:
            return "www.facebook.com"
        case .Gmail:
            return "www.gmail.com"
        case .SnapChat:
            return "www.snapchat.com"
        case .Instagram:
            return "www.instagram.com"
        case .LinkedIn:
            return "www.linkedin.com"
        case .custom:
            return ""
        }
    }
}
