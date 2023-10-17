//
//  BaseController.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 08/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import UIKit
import MBProgressHUD

@objc class BaseController: UIViewController {
    
    // MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Progress Methods
    func showProgress() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    func hideProgress() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // MARK: Alert Methods
    func showAlert(title:String, message:String) {
        showAlert(title: title, message: message) { }
    }
    
    func showAlert(title:String, message:String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.OK, style: .default, handler: { (action) in
            handler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String, button1Title: String?, button2Title: String?, button1Handler: @escaping () -> Void, button2Handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Button 1.
        alert.addAction(UIAlertAction(title: button1Title, style: .default, handler: { (action) in
            button1Handler()
        }))
        
        // Button 2.
        alert.addAction(UIAlertAction(title: button2Title, style: .cancel, handler: { (action) in
            button2Handler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: Error Handling Protocol
extension BaseController: ErrorHandlingProtocol {
    public func handleFailure(error: Error?) {
        self.hideProgress()
        self.showAlert(title:Constants.Error, message: error?.localizedDescription ?? "")
    }
}

// hud with message
