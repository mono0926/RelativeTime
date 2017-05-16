//
//  Threshold.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

public protocol ThresholdProtocol {
    func within(date: Date, now: Date) -> Bool
}

public enum Threshold: ThresholdProtocol {
    // TODO: Add more
    case
    seconds(TimeInterval),
    days(Int),
    sameYear

    public func within(date: Date, now: Date) -> Bool {
        switch self {
        case .seconds(let seconds):
            return now.timeIntervalSince(date) <= seconds
        case .days(let days):
            let target = date.addingTimeInterval(Double(3600 * 24 * (days - 1)))
            return target > now || Calendar.current.isDate(target, inSameDayAs: now)
        case .sameYear:
            return Calendar.current.dateComponents([.year], from: date).year ==
                Calendar.current.dateComponents([.year], from: now).year
        }
    }
}
