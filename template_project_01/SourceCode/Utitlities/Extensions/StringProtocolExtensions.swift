//
//  StringProtocolExtensions.swift
//  SwifterSwift
//
//  Created by Ahmed on 23/04/2019.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import Foundation

public extension StringProtocol {

    /// SwifterSwift: The longest common suffix.
    ///
    ///        "Hello world!".commonSuffix(with: "It's cold!") = "ld!"
    ///
    /// - Parameters:
    ///     - Parameter aString: The string with which to compare the receiver.
    ///     - Parameter options: Options for the comparison.
    /// - Returns: The longest common suffix of the receiver and the given String
    func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        guard !isEmpty && !aString.isEmpty else { return "" }

        var idx = endIndex
        var strIdx = aString.endIndex

        repeat {
            formIndex(before: &idx)
            aString.formIndex(before: &strIdx)

            guard String(self[idx]).compare(String(aString[strIdx]), options: options) == .orderedSame else {
                formIndex(after: &idx)
                break
            }

        } while idx > startIndex && strIdx > aString.startIndex

        return String(self[idx...])
    }

}
