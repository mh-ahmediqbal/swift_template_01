//
//  Theme.swift
//  TCLiOS
//
//  Created by VF on 14/06/2019.
//  Copyright © 2019 VF. All rights reserved.
//

import UIKit

class Theme {
    static let shared: Theme = Theme()
    
    // MARK: - FONTS
    static let textFont = UIFont.getTextFont()
    static let mediumTextFont = UIFont.getMediumTextFont()
    static let boldTextFont = UIFont.getBoldTextFont()
    static let largeTextFont = UIFont.getLargeTextFont()
    static let titleFont = UIFont.getTitleFont()
    static let navBarTitleFont = UIFont.getNavBarTitleFont()
    static let hintFont = UIFont.getHintFont()
    static let headerFont = UIFont.getHeaderFont()
    static let lightHeaderFont = UIFont.getLightHeaderFont()
    static let boldHeaderFont = UIFont.getBoldHeaderFont()
    
    
    // MARK: - COLORS
    static let primaryGrayColor = UIColor(rgb: 0xF2F2F2)
    static var primaryColor = UIColor(red: 222/255, green: 43/255, blue: 36/255, alpha: 1)
    static let primaryLightColor = UIColor(rgb: 0x4fb3bf)
    static let primaryDarkColor = UIColor(rgb: 0x4fb3bf)
    static let primaryTextColor = UIColor.white
    static let primaryDarkGrayColor = UIColor.darkGray
    static let secondaryColor = UIColor(rgb: 0xCA2A23)
    static let secondaryLightColor = UIColor(rgb: 0x8eacbb)
    static let secondaryDarkColor = UIColor(rgb: 0x34515e)
    static let secondaryTextColor = UIColor.init(rgb: 0xedf0f2)
}
