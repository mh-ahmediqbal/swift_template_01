//
//  String+Extension.swift
//  SwiftArchitecture
//
//  Created by Ahmed on 23/04/2019.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

extension String {
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
    
    func htmlEncodedString() ->String? {
        
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        return attributedString.string
    }
    
    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self
        
        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1
            
            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }
        
        return returnValue
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    func dateFromString() -> Date? {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss "
        return formatter.date(from: self)
    }
    
    func truncate(to length: Int, addEllipsis: Bool = false) -> String  {
        if length > count { return self }
        
        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]
        
        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }
    
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
    
}
// MARK: - Properties
public extension String {
    
    /// String decoded from base64  (if applicable).
    var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    /// String encoded in base64 (if applicable).
    var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// CamelCase of string.
    var camelCased: String {
        let source = lowercased()
        if source.contains(" ") {
            let first = source.substring(to: source.index(after: source.startIndex))
            let camel = source.capitalized.replacing(" ", with: "").replacing("\n", with: "")
            let rest = String(camel.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = source.lowercased().substring(to: source.index(after: source.startIndex))
            let rest = String(source.dropFirst())
            return "\(first)\(rest)"
            
        }
    }
    
    /// Check if string contains one or more emojis.
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// First character of string (if applicable).
    var firstCharacter: String? {
        return Array(self).map({String($0)}).first
    }
    
    /// Check if string contains one or more letters.
    var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// Check if string contains one or more numbers.
    var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// Check if string contains only letters.
    var isAlphabetic: Bool {
        return  hasLetters && !hasNumbers
    }
    
    /// Check if string contains at least one letter and one number.
    var isAlphaNumeric: Bool {
        return components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    /// Check if string is valid email format.
    //    public var isEmail: Bool {
    //        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    //        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    //        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    //        return emailTest.evaluate(with: self)
    //    }
    
    /// Check if string is https URL.
    var isHttpsUrl: Bool {
        guard start(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Check if string is http URL.
    var isHttpUrl: Bool {
        guard start(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Check if string contains only numbers.
    var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    /// Last character of string (if applicable).
    var lastCharacter: String? {
        guard let last = self.last else {
            return nil
        }
        return String(last)
    }
    
    /// Latinized string.
    var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// Array of strings separated by new lines.
    var lines: [String] {
        var result:[String] = []
        enumerateLines { (line, stop) -> () in
            result.append(line)
        }
        return result
    }
    
    /// The most common character in string.
    var mostCommonCharacter: String {
        var mostCommon = ""
        let charSet = Set(withoutSpacesAndNewLines.map{String($0)})
        var count = 0
        for string in charSet {
            if self.count(of: string) > count {
                count = self.count(of: string)
                mostCommon = string
            }
        }
        return mostCommon
    }
    
    /// Reversed string.
    var reversed: String {
        return String(self.reversed())
    }
    
    /// Bool value from string (if applicable).
    var bool: Bool? {
        let selfLowercased = self.trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        } else {
            return nil
        }
    }
    
    /// Date object from "yyyy-MM-dd" formatted string
    var date: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    var dateTime: Date? {
        let selfLowercased = self.trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// Double value from string (if applicable).
    var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }
    
    /// Float value from string (if applicable).
    var float: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }
    
    /// Float32 value from string (if applicable).
    var float32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }
    
    /// Float64 value from string (if applicable).
    var float64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }
    
    /// Integer value from string (if applicable).
    var int: Int? {
        return Int(self)
    }
    
    /// Int16 value from string (if applicable).
    var int16: Int16? {
        return Int16(self)
    }
    
    /// Int32 value from string (if applicable).
    var int32: Int32? {
        return Int32(self)
    }
    
    /// Int64 value from string (if applicable).
    var int64: Int64? {
        return Int64(self)
    }
    
    /// Int8 value from string (if applicable).
    var int8: Int8? {
        return Int8(self)
    }
    
    /// URL from string (if applicable).
    var url: URL? {
        return URL(string: self)
    }
    
    /// String with no spaces or new lines in beginning and end.
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Array with unicodes for all characters in a string.
    var unicodeArray: [Int] {
        return unicodeScalars.map({$0.hashValue})
    }
    
    /// Readable string from a URL string.
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// URL escaped string.
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    /// String without spaces and new lines.
    var withoutSpacesAndNewLines: String {
        return replacing(" ", with: "").replacing("\n", with: "")
    }
    
}


// MARK: - Methods
public extension String {
    
    /// Subscript string with index.
    ///
    /// - Parameter i: index.
    subscript(i: Int) -> String? {
        guard i >= 0 && i < self.count else {
            return nil
        }
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    /// Subscript string within a half-open range.
    ///
    /// - Parameter range: Half-open range.
    subscript(range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    /// Subscript string within a closed range.
    ///
    /// - Parameter range: Closed range.
    subscript(range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
    
    #if os(iOS)
    /// Copy string to global pasteboard.
    func copyToPasteboard() {
        UIPasteboard.general.string = self
    }
    #endif
    
    /// Converts string format to CamelCase.
    mutating func camelize() {
        self = camelCased
    }
    
    /// Check if string contains one or more instance of substring.
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    func contain(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    /// Count of substring in string.
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns:  count of substring in string.
    func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    /// Check if string ends with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    func end(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    /// First index of substring in string.
    ///
    /// - Parameter string: substring to search for.
    /// - Returns: first index of substring in string (if applicable).
    func firstIndex(of string: String) -> Int? {
        return Array(self).map({String($0)}).index(of: string)
    }
    
    /// Latinize string.
    mutating func latinize() {
        self = latinized
    }
    
    /// Random string of given length.
    ///
    /// - Parameter ofLength: number of characters in string.
    /// - Returns: random string of given length.
    static func random(ofLength: Int) -> String {
        var string = ""
        guard ofLength > 0 else {
            return string
        }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        for _ in 0..<ofLength {
            let randomIndex = arc4random_uniform(UInt32(base.count))
            string += "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
        }
        return string
    }
    
    /// String by replacing part of string with another string.
    ///
    /// - Parameters:
    ///   - substring: old substring to find and replace
    ///   - newString: new string to insert in old string place
    /// - Returns: string after replacing substring with newString
    func replacing(_ substring: String, with newString: String) -> String {
        return replacingOccurrences(of: substring, with: newString)
    }
    
    /// Reverse string.
    mutating func reverse() {
        self = String(self.reversed())
    }
    
    /// Sliced string from a start index with length.
    ///
    /// - Parameters:
    ///   - i: String index the slicing should start from.
    ///   - length: Amount of characters to be sliced after given index.
    /// - Returns: Sliced substring of length number of characters (if applicable) (example: "Hello world".slicing(from: 6, length: 5) -> "world")
    func slicing(from i: Int, length: Int) -> String? {
        guard length >= 0, i >= 0, i < self.count  else {
            return nil
        }
        guard i.advanced(by: length) <= self.count else {
            return slicing(at: i)
        }
        guard length > 0 else {
            return ""
        }
        return self[i..<i.advanced(by: length)]
    }
    
    /// Slice given string from a start index with length (if applicable).
    ///
    /// - Parameters:
    ///   - i: String index the slicing should start from.
    ///   - length: Amount of characters to be sliced after given index.
    mutating func slice(from i: Int, length: Int) {
        if let str = slicing(from: i, length: length) {
            self = str
        }
    }
    
    /// Sliced string from a start index to an end index.
    ///
    /// - Parameters:
    ///   - start: String index the slicing should start from.
    ///   - end: String index the slicing should end at.
    /// - Returns: Sliced substring starting from start index, and ends at end index (if applicable) (example: "Hello world".slicing(from: 6, to: 11) -> "world")
    func slicing(from start: Int, to end: Int) -> String? {
        guard end >= start else {
            return nil
        }
        return self[start..<end]
    }
    
    /// Slice given string from a start index to an end index (if applicable).
    ///
    /// - Parameters:
    ///   - start: String index the slicing should start from.
    ///   - end: String index the slicing should end at.
    mutating func slice(from start: Int, to end: Int) {
        if let str = slicing(from: start, to: end) {
            self = str
        }
    }
    
    /// Sliced string from a start index.
    ///
    /// - Parameter i: String index the slicing should start from.
    /// - Returns: Sliced substring starting from start index (if applicable) (example: "Hello world".slicing(at: 6) -> "world")
    func slicing(at i: Int) -> String? {
        guard i < self.count else {
            return nil
        }
        return self[i..<self.count]
    }
    
    /// Slice given string from a start index (if applicable).
    ///
    /// - Parameter i: String index the slicing should start from.
    mutating func slice(at i: Int) {
        if let str = slicing(at: i) {
            self = str
        }
    }
    
    /// Array of strings separated by given string.
    ///
    /// - Parameter separator: separator to split string by.
    /// - Returns: array of strings separated by given string.
    func splited(by separator: Character) -> [String] {
        return self.split{$0 == separator}.map(String.init)
    }
    
    /// Check if string starts with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    func start(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    /// Date object from string of date format.
    ///
    /// - Parameter format: date format
    /// - Returns: Date object from string (if applicable).
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /// Removes spaces and new lines in beginning and end of string.
    mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Truncate string (cut it to a given number of characters).
    ///
    /// - Parameters:
    ///   - toLength: maximum number of charachters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    mutating func truncate(toLength: Int, trailing: String? = "...") {
        guard toLength > 0 else {
            return
        }
        if self.count > toLength {
            self = self.substring(to: self.index(startIndex, offsetBy: toLength)) + (trailing ?? "")
        }
    }
    
    /// Truncated string (limited to a given number of characters).
    /// Truncated string (cut to a given number of characters).
    ///
    /// - Parameters:
    ///   - toLength: maximum number of charachters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    /// - Returns: truncated string (this is an exa...).
    func truncated(toLength: Int, trailing: String? = "...") -> String {
        guard self.count > toLength, toLength > 0 else {
            return self
        }
        return self.substring(to: self.index(startIndex, offsetBy: toLength)) + (trailing ?? "")
    }
    
    /// Convert URL string to readable string.
    mutating func urlDecode() {
        self = removingPercentEncoding ?? self
    }
    
    /// Escape string.
    mutating func urlEncode() {
        self = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
}


// MARK: - Operators
public extension String {
    
    /// Repeat string multiple times.
    ///
    /// - Parameters:
    ///   - lhs: string to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: string with character repeated n times.
    static func * (lhs: String, rhs: Int) -> String {
        var newString = ""
        for _ in 0 ..< rhs {
            newString += lhs
        }
        return newString
    }
    
    /// Repeat string multiple times.
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: string to repeat.
    /// - Returns: string with character repeated n times.
    static func * (lhs: Int, rhs: String) -> String {
        var newString = ""
        for _ in 0 ..< lhs {
            newString += rhs
        }
        return newString
    }
    
}


// MARK: - Initializers
public extension String {
    
    /// Create a new string from a base64 string (if applicable).
    ///
    /// - Parameter base64: base64 string.
    init?(base64: String) {
        if let str = base64.base64Decoded {
            self.init(str)
            return
        }
        return nil
    }
    
}


// MARK: - NSAttributedString extensions
public extension String {
    
    #if os(iOS)
    /// Bold string.
    var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif
    
    /// Underlined string
    var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Strikethrough string.
    var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    #if os(iOS)
    /// Italic string.
    var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
}


//MARK: - NSString extensions
public extension String {
    
    /// NSString from a string
    var nsString: NSString {
        return NSString(string: self)
    }
    
    /// NSString lastPathComponent
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    /// NSString pathExtension
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    /// NSString deletingLastPathComponent
    var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    /// NSString deletingPathExtension
    var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    /// NSString pathComponents
    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    /// NSString appendingPathExtension(str: String) (if applicable).
    func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
    
}
