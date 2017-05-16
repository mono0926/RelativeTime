//
//  TestUtil.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

struct TestUtil {
    /** 2017-03-25 14:00:00 */
    static let now = { () -> Date in
        var dc = DateComponents()
        dc.year = 2017
        dc.month = 3
        dc.day = 25
        dc.hour = 14
        return Calendar.current.date(from: dc)!
    }()
}
