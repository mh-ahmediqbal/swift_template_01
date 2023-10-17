//
//  HomeModels.swift
//  CleanTest
//
//  Created by Ahmed on 25/07/2023.
//  Copyright (c) 2023 Ahmed. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Home
{
  // MARK: Use cases
  
  enum ShowUserName
  {
    struct Request
    {
        
    }
    struct Response
    {
        var userName:String
    }
    struct ViewModel
    {
        var textToDisplay:String
    }
  }
}