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
        ThresholdRepresentation(upTo: .seconds(10)) { _, bundle in
            NSLocalizedString("Just now", bundle: bundle, comment: "")
        },
        ThresholdRepresentation(upTo: .days(1)) { date, _ in date.rt.digitTime },
        ThresholdRepresentation(upTo: .days(8)) { date, bundle in date.rt.dayOfWeek(bundle: bundle) },
        ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
    ]
}

extension Preset {
    public struct JoinUs {
        public static let usersList = [
            ThresholdRepresentation(upTo: .days(1)) { date, _ in date.rt.digitTime },
            ThresholdRepresentation(upTo: .days(8)) { date, bundle in date.rt.dayOfWeek(bundle: bundle) },
            ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
        ]
        public static let messagesList = [
            ThresholdRepresentation(upTo: .days(1)) { date, _ in date.rt.digitTime },
            ThresholdRepresentation(upTo: .days(2)) { date, _ in date.rt.digitTime },
            ThresholdRepresentation(upTo: .days(8)) { date, bundle in date.rt.dayOfWeek(bundle: bundle) },
            ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
        ]
    }
}
