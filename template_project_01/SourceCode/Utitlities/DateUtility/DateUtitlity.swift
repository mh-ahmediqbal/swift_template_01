//
//  DateUtitlity.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 12/11/2023.
//  Copyright © 2023 Ahmed. All rights reserved.
//

import UIKit

struct DateUtilityConstants {
    static let YYYYMMDD = "yyyy-MM-dd"
    static let YYYYMMDDTime = "MMM d, yyyy - HH:mm a"
    static let Time = "hh:mm a"
    static let ISO = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let GMT = "GMT"
}

class DateUtility: NSObject {
    
    // MARK: To String Methods
    
    static func getDateString(from date:Date, format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    // MARK: To Date Methods
    
    static func getDate(from string:String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: string)
    }
    
    // MARK: To Date Formatter Methods
    
    static func getDateFormatter(with format:String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: DateUtilityConstants.GMT)
        dateFormatter.dateFormat = format
        return dateFormatter
    }
    
    static func getYYYYMMDDDateFormatter() -> DateFormatter {
        return self.getDateFormatter(with: DateUtilityConstants.YYYYMMDD)
    }
    
}
