//
//  LoginModel.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 12/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class UserModel : BaseModel {
    // MARK: Properties
    var name : String?
    var dob : Date?
    var gender : String?
    var postalCode : String?
    var occupation : String?
    var relationshipStatus : String?
    
    // MARK: Initialize Methods
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Object Mapper
    override func mapping(map: Map) {
        super.mapping(map: map)
        name                    <- map["name"]
        dob                     <- (map["dob"], DateFormatterTransform(dateFormatter: DateUtility.getYYYYMMDDDateFormatter()))
        gender                  <- map["gender"]
        postalCode              <- map["postal_code"]
        occupation              <- map["occupation"]
        relationshipStatus      <- map["relationship_status"]
    }
}
