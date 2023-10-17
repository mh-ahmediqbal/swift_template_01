//
//  UIScreenExtension.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 23/04/2019.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Foundation

extension UIScreen {
    enum iPhoneDevice {
        case unknown
        case iPhone5_5s_5C
        case iPhone6_6s_7_8
        case iPhone6P_6sP_7P_8P
        case iPhoneX_Xs
        case iPhoneXr
        case iPhoneXsMax
    }
    
    static var device: iPhoneDevice {
        get {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return iPhoneDevice.iPhone5_5s_5C
            case 1334:
                return iPhoneDevice.iPhone6_6s_7_8
            case 2208:
                return iPhoneDevice.iPhone6P_6sP_7P_8P
            case 2436:
                return iPhoneDevice.iPhoneX_Xs
            case 1792:
                return iPhoneDevice.iPhoneXr
            case 2688:
                return iPhoneDevice.iPhoneXsMax
            default:
                return iPhoneDevice.unknown
            }
        }
    }
}
