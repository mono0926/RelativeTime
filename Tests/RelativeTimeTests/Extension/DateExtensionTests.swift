//
//  DateExtensionTests.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import XCTest
import Foundation
@testable import RelativeTime


class DateExtensionTests: XCTestCase {
    /** 2017-03-15 09:00:002017-03-25 14:00:00 */
    private static let now = { () -> Date in
        var dc = DateComponents()
        dc.year = 2017
        dc.month = 3
        dc.day = 25
        dc.hour = 14
        return Calendar.current.date(from: dc)!
    }()
    private var now: Date = DateExtensionTests.now
    private let date2017Start = { () -> Date in
        var dc = DateComponents()
        dc.year = 2017
        dc.month = 1
        dc.day = 1
        return Calendar.current.date(from: dc)!
    }()

    override class func setUp() {
        super.setUp()
        RelativeTime.defaultConfiguration.now = { now }
    }

    override func setUp() {
        super.setUp()
        RelativeTime.defaultConfiguration.representations = Preset.chat1
    }

    func test_JustNow() {
        XCTAssertEqual(now.rt.relative, "Just now")
        XCTAssertEqual(now.addingTimeInterval(-10).rt.relative, "Just now")
        XCTAssertNotEqual(now.addingTimeInterval(-11).rt.relative, "Just now")
    }

    func test_JustNow_Nothing() {
        RelativeTime.defaultConfiguration.representations = Preset.JoinUs.usersList
        XCTAssertEqual(now.rt.relative, "14:00")
        XCTAssertEqual(now.addingTimeInterval(-10).rt.relative, "13:59")
        XCTAssertNotEqual(now.addingTimeInterval(-11).rt.relative, "Just now")
    }

    func test_Within1Day() {
        XCTAssertEqual(now.addingTimeInterval(-11).rt.relative, "13:59")
        XCTAssertEqual(now.addingTimeInterval(-3600*14).rt.relative, "00:00")
        XCTAssertNotEqual(now.addingTimeInterval(-(3600*14+1)).rt.relative, "23:59")
    }

    func test_Within7Days() {
        XCTAssertEqual(now.addingTimeInterval(-(3600*14+1)).rt.relative, "Friday")
        XCTAssertEqual(now.addingTimeInterval(-(3600*(24*7+14))).rt.relative, "Saturday")
        XCTAssertNotEqual(now.addingTimeInterval(-(3600*(24*7+14)+1)).rt.relative, "Saturday")
    }

    func test_Within1Year() {
        XCTAssertEqual(now.addingTimeInterval(-(3600*(24*7+14)+1)).rt.relative, "3/17")
        XCTAssertEqual(date2017Start.rt.relative, "1/1")
        XCTAssertNotEqual(date2017Start.addingTimeInterval(-1).rt.relative, "1/1")
    }

    func test_Default() {
        XCTAssertEqual(date2017Start.addingTimeInterval(-1).rt.relative, "2016/12/31")
    }

    func test_Custom() {
        RelativeTime.defaultConfiguration.representations =
            [ThresholdRepresentation(upTo: Threshold.seconds(10)) { date in
                return "\(date)(　´･‿･｀)"
                }]
        XCTAssertTrue(now.rt.relative.hasSuffix("(　´･‿･｀)"))
    }

    func test_Custom2() {
        let rt = Configuration(defaultRepresentation: MyDefault(),
                                           representations: [MyRepresentation()],
                                           now: { self.now })
        XCTAssertEqual(now.rt.relative(rt), "(　´･‿･｀)")
    }
}

struct MyDefault: DefaultRepresentationProtocol {
    var representation: RepresentationType { return { _ in "default(　´･‿･｀)" } }
}
struct MyRepresentation: ThresholdRepresentationProtocol {
    var representation: RepresentationType { return { _ in "(　´･‿･｀)" } }
    var upTo: MyThreshold { return MyThreshold() }

}
struct MyThreshold: ThresholdProtocol {
    func within(date: Date, now: Date) -> Bool { return true }
}
