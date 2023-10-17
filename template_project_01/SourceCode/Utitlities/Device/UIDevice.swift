//
//  UIDevice.swift
//  Fuse3
//
//  Created by Ahmed on 19/03/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    var isMediumSize: Bool {
        #if targetEnvironment(simulator)
            let DEVICE_IS_SIMULATOR = true
        #else
            let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineString : String = ""
        if DEVICE_IS_SIMULATOR == true{
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineString = dir
            }
        }else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        switch machineString {
        case "iPod5,1":                                 return true
        case "iPod7,1":                                 return true
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return true
        case "iPhone4,1":                               return true
        case "iPhone5,1", "iPhone5,2":                  return true
        case "iPhone5,3", "iPhone5,4":                  return true
        case "iPhone6,1", "iPhone6,2":                  return true
        case "iPhone7,2":                               return true
        case "iPhone7,1":                               return false
        case "iPhone8,1":                               return true
        case "iPhone8,2":                               return false
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return false
        case "iPad3,1", "iPad3,2", "iPad3,3":           return false
        case "iPad3,4", "iPad3,5", "iPad3,6":           return false
        case "iPad4,1", "iPad4,2", "iPad4,3":           return false
        case "iPad5,3", "iPad5,4":                      return false
        case "iPad2,5", "iPad2,6", "iPad2,7":           return false
        case "iPad4,4", "iPad4,5", "iPad4,6":           return false
        case "iPad4,7", "iPad4,8", "iPad4,9":           return false
        case "iPad5,1", "iPad5,2":                      return false
        case "iPad6,7", "iPad6,8":                      return false
        case "AppleTV5,3":                              return false
        default:                                        return false
        }
    }
    var modelName: String {
        #if targetEnvironment(simulator)
            let DEVICE_IS_SIMULATOR = true
        #else
            let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineString : String = ""
        
        if DEVICE_IS_SIMULATOR == true
        {
            
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineString = dir
            }
        }
        else {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        }
        print(machineString)
        switch machineString {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        default:                                        return machineString
        }
    }
}
public extension UIDevice {
    
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case Unknown
    }
    var screenType: ScreenType {
        guard iPhone else { return .Unknown}
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208, 1920:
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        default:
            return .Unknown
        }
    }
    
}
