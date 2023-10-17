//
//  UIViewControllerExtensions.swift
//  <#Project Name#>
//
//  Created by Emirhan Erdogan on 07/08/16.
//  Copyright © 2017 <#Project Name#> All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


// MARK: - Properties
public extension UIViewController {
	
	/// Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
		// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
		return self.isViewLoaded && view.window != nil
	}
	
	/// NavigationBar in a ViewController.
//    public var navigationBar: UINavigationBar? {
//        return navigationController?.navigationBar
//    }
	
}

// MARK: - Methods
public extension UIViewController {
	
	/// Assign as listener to notification.
	///
	/// - Parameters:
	///   - name: notification name.
	///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}
	
	/// Unassign as listener to notification.
	///
	/// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}
	
	/// Unassign as listener from all notifications.
    func removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}
	
}

#endif
extension UIViewController {
    
    // MARK: - UIAlertController
    
    typealias AlertViewDismissHandler = () -> Void
    typealias AlertViewCurrentPasswordConfirmedHandler = (String) -> Void
    
    func showAlertViewWithTitle(title:String,message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        present(alertController, animated: true, completion:nil)
    }
    
    func showConfirmationAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewDismissHandler))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { action -> Void in
            //Do some other stuff
            dismissCompletion()
        }))
        
        alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { action -> Void in
            //Do some other stuff
            
        }))
        
        present(alertController, animated: true, completion:nil)
    }
    
    func showCurrentPasswordConfirmationAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewCurrentPasswordConfirmedHandler))
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            dismissCompletion("")
        }
        alertController.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .default) { action -> Void in
            let textField:UITextField = (alertController.textFields?.first)!
            dismissCompletion(textField.text!)
            
        }
        alertController.addAction(nextAction)
        alertController.addTextField { textField -> Void in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
            textField.textColor = UIColor.blue
            textField.addTarget(self, action: Selector(("alertTextFieldDidChange:")), for: UIControl.Event.editingChanged)
        }
        present(alertController, animated: true, completion:nil)
        
    }
    private func alertTextFieldDidChange(textField:UITextField) -> Void {
        let presentedAlertController:UIAlertController! = (self.presentedViewController! as! UIAlertController)
        let textField:UITextField! = presentedAlertController.textFields?.first
        let okAction:UIAlertAction! = presentedAlertController.actions.last
        okAction.isEnabled = (textField.text?.length)!>2
        
    }
    
    func showTextInputAlertViewWithTitle(title:String,message : String, dismissCompletion:@escaping (AlertViewCurrentPasswordConfirmedHandler))
    {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            dismissCompletion("")
        }
        alertController.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .default) { action -> Void in
            let textField:UITextField = (alertController.textFields?.first)!
            dismissCompletion(textField.text!)
            
        }
        alertController.addAction(nextAction)
        alertController.addTextField { textField -> Void in
            textField.placeholder = "Enter something"
            textField.textColor = UIColor.black
        }
        present(alertController, animated: true, completion:nil)
        
    }
    
}
