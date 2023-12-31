//
//  HomeInteractor.swift
//  CleanTest
//
//  Created by Shuja ud Din on 25/07/2023.
//  Copyright (c) 2023 Shuja ud Din. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeBusinessLogic
{
  func showUserName(request: Home.ShowUserName.Request)
}

protocol HomeDataStore
{
  var userName: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
  var presenter: HomePresentationLogic?
  var worker: HomeWorker?
  var userName: String = ""
  
  // MARK: Do something
  
  func showUserName(request: Home.ShowUserName.Request)
  {
    worker = HomeWorker()
    worker?.doSomeWork()
    
    let response = Home.ShowUserName.Response(userName: userName)
    presenter?.presentUserName(response: response)
  }
}
