//
//  CEMKit+UIFont.swift
//
//
//  Created by Cem Olcay on 12/08/15.
//
//

#if os(iOS) || os(tvOS)

import UIKit

/// EZSwiftExtensions
public enum FontType: String {
    case None = ""
    case Regular = "Regular"
    case Bold = "Bold"
    case DemiBold = "DemiBold"
    case Light = "Light"
    case UltraLight = "UltraLight"
    case Italic = "Italic"
    case Thin = "Thin"
    case Book = "Book"
    case Roman = "Roman"
    case Medium = "Medium"
    case MediumItalic = "MediumItalic"
    case CondensedMedium = "CondensedMedium"
    case CondensedExtraBold = "CondensedExtraBold"
    case SemiBold = "SemiBold"
    case BoldItalic = "BoldItalic"
    case Heavy = "Heavy"
}

/// EZSwiftExtensions
public enum FontName: String {
    case HelveticaNeue
    case Helvetica
    case Futura
    case Menlo
    case Avenir
    case AvenirNext
    case Didot
    case AmericanTypewriter
    case Baskerville
    case Geneva
    case GillSans
    case SanFranciscoDisplay
    case Seravek
}

extension UIFont {

    /// EZSwiftExtensions
    public class func Font(_ name: FontName, type: FontType, size: CGFloat) -> UIFont! {
      //Using type
      let fontName = name.rawValue + "-" + type.rawValue
      if let font = UIFont(name: fontName, size: size) {
          return font
      }

      //That font doens't have that type, try .None
      let fontNameNone = name.rawValue
      if let font = UIFont(name: fontNameNone, size: size) {
          return font
      }

      //That font doens't have that type, try .Regular
      let fontNameRegular = name.rawValue + "-" + "Regular"
      if let font = UIFont(name: fontNameRegular, size: size) {
          return font
      }

      return nil
    }

    /// EZSwiftExtensions
    public class func HelveticaNeue(type: FontType, size: CGFloat) -> UIFont {
        return Font(.HelveticaNeue, type: type, size: size)
    }

    /// EZSwiftExtensions
    public class func AvenirNext(type: FontType, size: CGFloat) -> UIFont {
        return Font(.AvenirNext, type: type, size: size)
    }

    /// EZSwiftExtensions
    public class func AvenirNextDemiBold(size: CGFloat) -> UIFont {
        return Font(.AvenirNext, type: .DemiBold, size: size)
    }

    /// EZSwiftExtensions
    public class func AvenirNextRegular(size: CGFloat) -> UIFont {
        return Font(.AvenirNext, type: .Regular, size: size)
    }

    // MARK: Deprecated

    /// EZSwiftExtensions
    @available(*, deprecated)
    public class func PrintFontFamily(_ font: FontName) {
        let arr = UIFont.fontNames(forFamilyName: font.rawValue)
        for name in arr {
            print(name)
        }
    }
    
    class func getTextFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Regular", size: 12)!
        }
        return UIFont(name: "Roboto-Regular", size: 14)!
    }
    
    class func getMediumTextFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Medium", size: 12)!
        }
        return UIFont(name: "Roboto-Medium", size: 14)!
    }
    
    class func getBoldTextFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Bold", size: 12)!
        }
        return UIFont(name: "Roboto-Bold", size: 14)!
    }
    
    class func getDetailTextFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Regular", size: 10)!
        }
        return UIFont(name: "Roboto-Regular", size: 12)!
    }
    
    class func getLargeTextFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Medium", size: 15)!
        }
        return UIFont(name: "Roboto-Medium", size: 20)!
    }
    
    class func getTitleFont() -> UIFont {
        return UIFont(name: "Roboto-Regular", size: 15)!
    }
    
    class func getNavBarTitleFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Medium", size: 12)!
        }
        return UIFont(name: "Roboto-Medium", size: 14)!
    }
    
    class func getHintFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Regular", size: 7)!
        }
        return UIFont(name: "Roboto-Regular", size: 9)!
    }
    
    class func getHeaderFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Regular", size: 10)!
        }
        return UIFont(name: "Roboto-Regular", size: 12)!
    }
    
    class func getLightHeaderFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Light", size: 10)!
        }
        return UIFont(name: "Roboto-Light", size: 12)!
    }
    
    class func getBoldHeaderFont() -> UIFont {
        if UIDevice.current.screenType == .iPhone5 {
            return UIFont(name: "Roboto-Bold", size: 10)!
        }
        return UIFont(name: "Roboto-Bold", size: 12)!
    }
}

#endif
