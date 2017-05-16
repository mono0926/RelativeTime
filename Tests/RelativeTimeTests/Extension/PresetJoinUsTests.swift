//
//  PresetJoinUsTests.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import XCTest
import Foundation
@testable import RelativeTime

class PresetJoinUsTests: XCTestCase {
    /** 2017-03-25 14:00:00 */
    private static let now = TestUtil.now
    private var now: Date = TestUtil.now

    override class func setUp() {
        super.setUp()
        RelativeTime.defaultConfiguration.now = { now }
    }

    override func setUp() {
        super.setUp()
        RelativeTime.defaultConfiguration.representations = Preset.JoinUs.messagesList
    }

    func testMessageList_today() {
        XCTAssertEqual(now.rt.relative, "Today")
        XCTAssertEqual(now.addingTimeInterval(-3600*14).rt.relative, "Today")
        XCTAssertNotEqual(now.addingTimeInterval(-(3600*14+1)).rt.relative, "Today")
    }

    func testMessageList_yeasterday() {
        XCTAssertEqual(now.addingTimeInterval(-(3600*14+1)).rt.relative, "Yesterday")
        XCTAssertEqual(now.addingTimeInterval(-3600*38).rt.relative, "Yesterday")
        XCTAssertNotEqual(now.addingTimeInterval(-(3600*38+1)).rt.relative, "Yesterday")
    }

    func test_Within7Days() {
        XCTAssertEqual(now.addingTimeInterval(-(3600*38+1)).rt.relative, "Thursday")
        XCTAssertEqual(now.addingTimeInterval(-(3600*(24*7+14))).rt.relative, "Saturday")
        XCTAssertNotEqual(now.addingTimeInterval(-(3600*(24*7+14)+1)).rt.relative, "Saturday")
    }
}
