//
//  NetworkManager.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 08/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import Foundation
import Alamofire
import CocoaLumberjack
import SwiftyJSON

public class NetworkManager: ErrorHandlingProtocol {
    
    static let manager: NetworkManager = NetworkManager()

    enum Endpoints {
        case login(String,String)
        case logout(String,String)
        
        public var method: HTTPMethod {
            switch self {
            case .login:
                return .post
            case .logout:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .login:
                return NetworkConstants.BaseUrl + NetworkConstants.LoginEndpoint
            case .logout:
                return NetworkConstants.BaseUrl + NetworkConstants.LogoutEndpoint
            }
        }
        
        var headers: HTTPHeaders {
            // Create headers.
            var headers:HTTPHeaders = [:]
            
            // Set accept.
            headers[NetworkConstants.AcceptHeaderKey] = headers[NetworkConstants.AcceptHeaderValue]
            
            // Return Headers.
            return headers
        }
        
        var parameters: JSON {
            var parameters:JSON = [:]
            switch self {
            case .login(let email,let password):
                parameters = [ NetworkConstants.EmailKey : email , NetworkConstants.PassworkKey : password]
                break
            case .logout(let email, let password):
                parameters = [ NetworkConstants.EmailKey : email , NetworkConstants.PassworkKey : password]
                break
            }
            return parameters
        }
    }
        
    
    func request(
        endpoint: NetworkManager.Endpoints,
        success:@escaping (JSON) -> Void,
        failure:@escaping (Error) -> Void) {
        
        if (!GeneralUtility.isNetworkAvaliable()) {
            failure(GeneralUtility.getError(with: Constants.ErrorInternetConnection))
            return
        }

        let _ = SessionManager.default.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters.dictionaryObject, encoding: URLEncoding.default, headers: endpoint.headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if(json != JSON.null) {
                    success(json)
                }
            case .failure(let error):
                self.handleFailure(error: error)
                failure(error)
            }
        }
    }
    
    func handleFailure(error: Error?) {
        print(error?.localizedDescription ?? Constants.Error)
    }
}


