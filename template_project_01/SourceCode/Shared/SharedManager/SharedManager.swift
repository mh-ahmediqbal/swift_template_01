//
//  SharedManager.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 08/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import UIKit

class SharedManager: NSObject {
    static let manager: SharedManager = SharedManager()
    
    var userName : String?
    
    private override init() {
        
    }
    
}
