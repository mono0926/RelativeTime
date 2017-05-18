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

    func testUsersList() {
        XCTAssertEqual(Preset.JoinUs.usersList[0].representation(now, RTBundle.bundle), "14:00")
        XCTAssertEqual(Preset.JoinUs.usersList[1].representation(now, RTBundle.bundle), "Saturday")
        XCTAssertEqual(Preset.JoinUs.usersList[2].representation(now, RTBundle.bundle), "3/25")
    }

    func testMessageList() {
        XCTAssertEqual(Preset.JoinUs.messagesList[0].representation(now, RTBundle.bundle), "Today")
        XCTAssertEqual(Preset.JoinUs.messagesList[1].representation(now, RTBundle.bundle), "Yesterday")
        XCTAssertEqual(Preset.JoinUs.messagesList[2].representation(now, RTBundle.bundle), "Saturday")
        XCTAssertEqual(Preset.JoinUs.messagesList[3].representation(now, RTBundle.bundle), "3/25")
    }
}
