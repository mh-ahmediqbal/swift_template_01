//
//  LoginModel+ServiceManager.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 12/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//
import ObjectMapper

extension UserModel {
    
    public static func loginUser(with username: String, password: String, success: @escaping (UserModel) -> Void, failure:@escaping (Error) -> Void) {
        
        NetworkManager.manager.request(endpoint: .login(username, password) , success: { (json) in
            
            let user = Mapper<UserModel>().map(JSON: json.dictionaryObject!)
            success(user!)
            
        }) { (error) in
            failure(error)
        }
        
    }
    
}
