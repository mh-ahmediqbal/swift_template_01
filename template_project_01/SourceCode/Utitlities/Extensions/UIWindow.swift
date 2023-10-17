//
//  UIWindow.swift
//  TDMall
//
//  Created by Shuja on 2/21/19.
//  Copyright © 2019 Emaar Corp. All rights reserved.
//

import Foundation
import UIKit

public extension UIWindow {
    
    
    
    
    /** @return Returns the current Top Most ViewController in hierarchy.   */
    
    func topMostWindowController()->UIViewController? {
        
        
        
        var topController = rootViewController
        
        
        
        while let presentedController = topController?.presentedViewController {
            
            topController = presentedController
            
        }
        
        
        
        return topController
        
    }
    
    
    
    /** @return Returns the topViewController in stack of topMostWindowController.    */
    
    func currentViewController()->UIViewController? {
        
        
        
        var currentViewController = topMostWindowController()
        
        
        
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            
            currentViewController = (currentViewController as! UINavigationController).topViewController
            
        }
        
        
        
        
        return currentViewController
        
    }
    
}
