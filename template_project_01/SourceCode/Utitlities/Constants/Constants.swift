//
//  Constants.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 08/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: General
    static let AppName = ""
    static let OK = "OK"
    static let Yes = "Yes"
    static let No = "No"
    static let Cancel = "Cancel"
    static let Next = "Next"
    static let Logout = "Logout"
    static let Error = "Error"
    static let Plist = "plist"
    static let HTTP = "http://"
    static let HTTPS = "https://"
    
    // MARK: Storyboards
    static let Main = "Main"

    // MARK: Identifiers
    static let FirstViewController = "FirstViewContoller"

    // MARK: Plist Names

    // MARK: Error
    static let AppDomain = ""
    static let AppErrorCode = 1000
    
    // MARK: Success Messages
    
    // MARK: Error Messages
    static let ErrorInternetConnection = "Internet connection appears to be offline."
    static let EmailAlreadyExistError = "Email address is not available."
    static let PasswordConfirmationError = "Password do not match."

    static let ServerConnectionError = "We are unable to connect to the server at the moment. Please retry later."

    // MARK: Regex
    static let EmailRegex = "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}"
    
    // MARK: - Validations
    static let kValidate_Numeric:String  = "0123456789"
    static let kValidate_NumericPlus:String  = "0123456789+"
    static let kValidate_AlphaNumeric:String  = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    static let toast_duration = 0.75
    static let userNotFound = "User not found!"
    
    static func getValidate_Numeric() -> String{
        return Constants.kValidate_Numeric
    }
    
    static func getValidate_AlphaNumeric() -> String{
        return Constants.kValidate_AlphaNumeric
    }
    
    static func getValidate_NumericPlus() -> String {
        return Constants.kValidate_NumericPlus
    }

}
