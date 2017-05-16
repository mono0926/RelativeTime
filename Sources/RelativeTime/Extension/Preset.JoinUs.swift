//
//  Preset.JoinUs.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

extension Preset {
    public struct JoinUs {
        public static let usersList = [
            ThresholdRepresentation(upTo: .days(1)) { date, _ in date.rt.digitTime },
            ThresholdRepresentation(upTo: .days(8)) { date, bundle in date.rt.dayOfWeek(bundle: bundle) },
            ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
        ]
        public static let messagesList = [
            ThresholdRepresentation(upTo: .days(1)) { date, bundle in NSLocalizedString("Today", bundle: bundle, comment: "") },
            ThresholdRepresentation(upTo: .days(2)) { date, bundle in NSLocalizedString("Yesterday", bundle: bundle, comment: "") },
            ThresholdRepresentation(upTo: .days(8)) { date, bundle in date.rt.dayOfWeek(bundle: bundle) },
            ThresholdRepresentation(upTo: .sameYear) { date, _ in date.rt.digitDate }
        ]
    }
}
