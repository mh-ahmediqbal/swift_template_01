//
//  UserProfile.swift
//  template_project_01
//
//  Created by Ahmed on 11/07/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import Foundation


public final class UserProfile: NSObject,NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let email = "email"
    static let id = "id"
    static let lastName = "lastName"
    static let userName = "name"
    static let firstName = "firstName"
    static let cusotmerId = "customer_id"
    static let avatar = "avatar"
    static let telNumber = "tel"
    static let sessionKey = "session"
    
  }

  // MARK: Properties
  public var email: String?
  public var id: Int?
  public var lastName: String?
  public var userName: String?
  public var firstName: String?
    
    public var avatar: String?
    public var cusotmerId: String?
    public var telNumber: String?
    public var sessionKey: String?
    

    override init () {
        // uncomment this line if your class has been inherited from any other class
        //super.init()
    }
    
    //
    
    convenience init(_ dictionary: Dictionary<String, Any>) {
        self.init()
        email = dictionary[SerializationKeys.email] as? String
        id = dictionary[SerializationKeys.id] as? Int
        lastName = dictionary[SerializationKeys.lastName] as? String
        firstName = dictionary[SerializationKeys.firstName] as? String
        userName = dictionary[SerializationKeys.userName] as? String
        cusotmerId = dictionary[SerializationKeys.cusotmerId] as? String
        avatar = dictionary[SerializationKeys.avatar] as? String
        telNumber = dictionary[SerializationKeys.telNumber] as? String
        sessionKey = dictionary[SerializationKeys.sessionKey] as? String
    }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
    
    self.userName = aDecoder.decodeObject(forKey: SerializationKeys.userName) as? String
    self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
    self.avatar = aDecoder.decodeObject(forKey: SerializationKeys.avatar) as? String
    self.cusotmerId = aDecoder.decodeObject(forKey: SerializationKeys.cusotmerId) as? String
    self.telNumber = aDecoder.decodeObject(forKey: SerializationKeys.telNumber) as? String
    self.sessionKey = aDecoder.decodeObject(forKey: SerializationKeys.sessionKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(lastName, forKey: SerializationKeys.lastName)
    aCoder.encode(userName, forKey: SerializationKeys.userName)
    aCoder.encode(firstName, forKey: SerializationKeys.firstName)
    aCoder.encode(avatar, forKey: SerializationKeys.avatar)
    aCoder.encode(cusotmerId, forKey: SerializationKeys.cusotmerId)
    aCoder.encode(telNumber, forKey: SerializationKeys.telNumber)
    aCoder.encode(sessionKey, forKey: SerializationKeys.sessionKey)

  }

}
