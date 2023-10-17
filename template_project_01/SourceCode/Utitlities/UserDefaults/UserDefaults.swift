//
//  UserDefaults.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 08/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import UIKit

class AppUserDefaults: NSObject {
    
    // MARK: Generic Setter And Getter
    // Object.
    static func set(_ value: Any?, forKey defaultName: String) {
        if let value = value {
            UserDefaults.standard.set(value, forKey: defaultName)
        }
        else {
            UserDefaults.standard.removeObject(forKey: defaultName)
        }
        UserDefaults.standard.synchronize()
    }
    
    static func object(forKey defaultName: String) -> Any? {
        return UserDefaults.standard.object(forKey: defaultName)
    }
    
    
    // Properties
    @objc static var sessionInfo: String? {
        get {
            return object(forKey: #keyPath(AppUserDefaults.sessionInfo)) as? String
        }
        set {
            set(newValue, forKey: #keyPath(AppUserDefaults.sessionInfo))
        }
    }
    
    // Save data on groups basis.
}
