//
//  NetworkConstants.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 08/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//


import Foundation

struct NetworkConstants {
    
    // MARK: URLs.
    static let BaseUrl = "http://staging.tclpakistan.com/mobileapi"
    
    // MARK: Endpoints.
    static let LoginEndpoint = "/users/login"
    static let LogoutEndpoint = "users/logout"
    
    //MARK: Headers.
    static let AcceptHeaderKey = "Accept"
    static let AcceptHeaderValue = "application/json"
    
    static let EmailKey = "email"
    static let PassworkKey = "pwd"
}
