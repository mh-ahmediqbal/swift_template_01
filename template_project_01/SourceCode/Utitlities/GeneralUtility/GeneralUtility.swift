//
//  GeneralUtility.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 08/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import UIKit
import Reachability
import CocoaLumberjack
import Foundation
import SystemConfiguration

class GeneralUtility: NSObject {
    
    // MARK: Size Methods
    
    static func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }

    
    // MARK: Network Methods
    static func isNetworkAvaliable() -> Bool {
        let reachability = try? Reachability()
        switch reachability?.connection {
            case .cellular:
                return true
            case .wifi:
                return true
            case .unavailable:
                return false
            default:
                return true
        }
    }


    // MARK: Error Methods
    
    static func getError(with message:String?, code: Int?) -> Error {
        return NSError(domain: Constants.AppDomain, code: code ?? Constants.AppErrorCode, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
    
    static func getError(with message:String?) -> Error {
        return NSError(domain: Constants.AppDomain, code: Constants.AppErrorCode, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
    
    // MARK: Font Methods
    
    static func boldFont(for font:UIFont?) -> UIFont? {
        return self.getFont(from: font, previous: "Regular", to: "Bold")
    }
    
    static func regularFont(for font:UIFont?) -> UIFont? {
        return self.getFont(from: font, previous: "Bold", to: "Regular")
    }
    
    static func smallFont(for font:UIFont?) -> UIFont? {
        let newFont = UIFont(name: font?.fontName ?? "", size: ((font?.pointSize ?? 10) * 0.7))
        return newFont
    }
    
    static func getFont(from currentFont:UIFont?, previous:String, to new:String) -> UIFont? {
        let newFontName = currentFont?.fontName.replacingOccurrences(of: previous, with: new)
        let newFont = UIFont(name: newFontName ?? "", size: currentFont?.pointSize ?? 10)
        return newFont
    }
    
    // MARK : Convert Hex to Color
    // MARK : Add Borders + round corner to View
    // MARK : Set custom color for border
    
    // MARK: - Validations
    
    class func isValidEmailAddress(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    static func getFormattedStringFromNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value : number))!
    }
    
    static func getFormattedStringFromDate(_ aDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: aDate)
    }
    
    class func isValidateNumber(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: Constants.getValidate_Numeric())
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidateAlphabet(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: Constants.getValidate_AlphaNumeric())
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidateAlphabetWithWhiteSpace(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: Constants.getValidate_AlphaNumeric())
        var characterCount: Int32 = 0
        //        var i: Int
        
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
    
    class func isValidStringNumericPlus(_ checkString: NSString) -> Bool {
        let numcharacters: CharacterSet = CharacterSet(charactersIn: Constants.getValidate_NumericPlus())
        var characterCount: Int32 = 0
        //        var i: Int
        for i in 0 ..< checkString.length {
            let character: unichar = checkString.character(at: i)
            if !numcharacters.contains(UnicodeScalar(character)!) {
                characterCount += 1
            }
        }
        if characterCount == 0 {
            return true
        } else {
            return false
            
        }
    }
}
extension GeneralUtility {
    //MARK: - JSON Response Serialization
    
    class func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
}
