//
//  Preset.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

public struct Preset {
    public static let chat1 = [
        ThresholdRepresentation(upTo: .seconds(10)) { _ in
            NSLocalizedString("Just now", bundle: RTBundle.bundle, comment: "")
        },
        ThresholdRepresentation(upTo: .days(1)) { date, _ in date.rt.digitTime },
        ThresholdRepresentation(upTo: .days(8)) { date, _ in date.rt.dayOfWeek },
        ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
    ]
}

extension Preset {
    public struct JoinUs {
        public static let usersList = [
            ThresholdRepresentation(upTo: .days(1)) { date, _ in date.rt.digitTime },
            ThresholdRepresentation(upTo: .days(8)) { date, _ in date.rt.dayOfWeek },
            ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
        ]
        public static let messagesList = [
            ThresholdRepresentation(upTo: .days(1)) { date, _ in date.rt.digitTime },
            ThresholdRepresentation(upTo: .days(2)) { date, _ in date.rt.digitTime },
            ThresholdRepresentation(upTo: .days(8)) { date, _ in date.rt.dayOfWeek },
            ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
        ]
    }
}
