//
//  Date.swift
//  PrimerCheckout
//
//  Created by Antonio Zdelican on 06.08.21.
//

import Foundation

internal extension Date {

    var string: String {
        return Formatter.iso8601.string(from: self)
    }
}

internal struct Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
}
