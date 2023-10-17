//
//  LoginAPI.swift
//  Directooo
//
//  Created by Ahmed on 12/10/2023.
//  Copyright (c) 2023 Ahmed. All rights reserved.
//

import Foundation
import Moya


// MARK: - RegistrationAPIProvider

let loginAPIProvider = MoyaProvider<UserAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: GeneralUtility.JSONResponseDataFormatter)])

enum UserAPI {
    
    case login(Dictionary<String, Any>)
    case signUp(Dictionary<String, Any>)
    case forgotPassword(Dictionary<String, Any>)
    case updatePassword(Dictionary<String, Any>)
}

extension UserAPI : TargetType {
    
    var baseURL: URL {
        
        guard let url = URL(string: NetworkConstants.BaseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        
        switch self {
            
        case .login:
            return "/customer/login"
            
        case .signUp:
            return "/customer/register"
            
        case .forgotPassword:
            return "/customer/forgotPassword"
            
        case .updatePassword:
            return "/customer/updatePassword"
            
        }
    }
    
    var method: Moya.Method {
        
        switch self {
        case .login:
            return .post
            
        case .signUp:
            return .post
            
        case .forgotPassword:
            return .post
            
        case .updatePassword:
            return .post
        }
    }
    
    var sampleData: Data {
        
        return Data()
    }
    
    var task: Task {
        
        switch self {
            
        case .login(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .signUp(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .forgotPassword(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
         
        case .updatePassword(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
        return ["accept" : "application/json"]
    }
}
// MARK: - Response Handlers

extension Moya.Response {
    func mapDictionary() throws -> Dictionary<String, Any> {
        let any = try self.mapJSON()
        guard let dic = any as? Dictionary<String, Any> else {
            throw MoyaError.jsonMapping(self)
        }
        return dic
    }
}
