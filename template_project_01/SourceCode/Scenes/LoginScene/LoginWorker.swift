//
//  LoginWorker.swift
//  CleanTest
//
//  Created by Ahmed on 24/07/2023.
//  Copyright (c) 2023 Ahmed. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import NVActivityIndicatorView
import ObjectMapper
import SwiftyJSON

class LoginWorker
{
    typealias loginResponseHandler = (_ response: Login.SignIn.Response) ->()
    func signIn(params : Dictionary<String, Any> , success:@escaping(loginResponseHandler), fail:@escaping(loginResponseHandler)) {
        
//        let activityData = ActivityData()
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        
        loginAPIProvider.request(UserAPI.login(params)) { (result) in
            
//            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            
            switch result {
                
            case .success(_):
                do {
                    
                    let response    = try result.get()
                    let value       = try response.mapDictionary()
                    let user        = value["model"] as? Dictionary<String, Any> ?? ["" : ""]
                    let msg         = value["msg"] as? String ?? "Success!"
                    let code        = value["code"] as? String ?? "0"
                    let userModel   = UserProfile(user)
                    if code         == "0" {

                        let response = Login.SignIn.Response(user: userModel, success: true, message: msg)
                        success(response)
                    }
                    else {

                        let response = Login.SignIn.Response(user: nil, success: false, message: Constants.userNotFound)
                        fail(response)
                    }
                    
                } catch let err {
                    print(err)
                }
                
            case let .failure(error):
                print(error)
                
                let message = error.localizedDescription
                let response = Login.SignIn.Response(user: nil, success: false, message: message)
                fail(response)
            }
        }
        

        
    }
}
