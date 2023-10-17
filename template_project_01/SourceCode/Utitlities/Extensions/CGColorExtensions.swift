//
//  CGColorExtensions.swift
//  SwifterSwift
//
//  Created by Ahmed on 23/04/2019.
//  Copyright © 2019 Ahmed. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

// MARK: - Properties
public extension CGColor {

    #if canImport(UIKit)
    /// SwifterSwift: UIColor.
    var uiColor: UIColor? {
        return UIColor(cgColor: self)
    }
    #endif

    #if canImport(Cocoa)
    /// SwifterSwift: NSColor.
    var nsColor: NSColor? {
        return NSColor(cgColor: self)
    }
    #endif

}

#endif
