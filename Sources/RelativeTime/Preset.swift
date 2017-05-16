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
        ThresholdRepresentation(upTo: .days(1)) { date in date.rt.digitTime },
        ThresholdRepresentation(upTo: .days(8)) { date in date.rt.dayOfWeek },
        ThresholdRepresentation(upTo: .sameYear) { date in date.rt.digitDate }
    ]
    public static let chat2 = [
        ThresholdRepresentation(upTo: .days(1)) { date in date.rt.digitTime },
        ThresholdRepresentation(upTo: .days(8)) { date in date.rt.dayOfWeek },
        ThresholdRepresentation(upTo: .sameYear) { date in date.rt.digitDate }
    ]
}
