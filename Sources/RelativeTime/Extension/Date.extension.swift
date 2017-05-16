//
//  Date.extension.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

extension Date: ExtensionCompatible {}

private let locale = Locale(identifier: "en_US_POSIX")
private let digitTimeFormatter = { () -> DateFormatter in
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateFormat = "HH:mm"
    return formatter
}()
private let weekFormatter = { () -> DateFormatter in
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateFormat = "EEEE"
    return formatter
}()
private let digitDateFormatter = { () -> DateFormatter in
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateFormat = "M/d"
    return formatter
}()
private let digitYearDateFormatter = { () -> DateFormatter in
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateFormat = "YYYY/MM/dd"
    return formatter
}()

extension Extension where Base == Date {
    var digitTime: String {
        return digitTimeFormatter.string(from: base)
    }
    var digitDate: String {
        return digitDateFormatter.string(from: base)
    }
    var digitYearDate: String {
        return digitYearDateFormatter.string(from: base)
    }
    var dayOfWeek: String {
        return NSLocalizedString(weekFormatter.string(from: base).capitalized, bundle: RTBundle.bundle, comment: "")
    }
    func isSameDay(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }

    public var relative: String {
        return relative(RelativeTime.defaultConfiguration)
    }

    public func relative<T>(_ configuration: Configuration<T>) -> String {
        let now = configuration.now()
        for r in configuration.representations {
            if r.upTo.within(date: base, now: now) {
                return r.representation(base, configuration.bundle)
            }
        }
        return configuration.defaultRepresentation.representation(base, configuration.bundle)
    }
}
