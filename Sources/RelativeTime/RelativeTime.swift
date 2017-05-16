import Foundation

public class RelativeTimeBundle {
    static let bundle = Bundle(for: RelativeTimeBundle.self)
}

public protocol RelativeTimeDefaultRepresentation {
    var result: ((Date) -> String) { get }
}
public protocol RelativeTimeRepresentation: RelativeTimeDefaultRepresentation {
    associatedtype Threshold: RelativeTimeThreshold
    var upTo: Threshold { get }
}

public protocol RelativeTimeThreshold {
    func within(date: Date, now: Date) -> Bool
}

public struct RelativeTime {
    private init() {}

    public static var defaultConfiguration = Configuration(
        defaultRepresentation: DefaultRepresentation { date in date.rt.digitYearDate },
        representations: Preset.chat1)

    public struct Preset {
        public static let chat1 = [
            Representation(upTo: .seconds(10)) { _ in
                NSLocalizedString("Just now", bundle: RelativeTimeBundle.bundle, comment: "")
            },
            Representation(upTo: .days(1)) { date in date.rt.digitTime },
            Representation(upTo: .days(8)) { date in date.rt.dayOfWeek },
            Representation(upTo: .sameYear) { date in date.rt.digitDate }
        ]
        public static let chat2 = [
            Representation(upTo: .days(1)) { date in date.rt.digitTime },
            Representation(upTo: .days(8)) { date in date.rt.dayOfWeek },
            Representation(upTo: .sameYear) { date in date.rt.digitDate }
        ]
    }

    // TODO: Add more
    public enum Threshold: RelativeTimeThreshold {
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

    public struct DefaultRepresentation: RelativeTimeDefaultRepresentation {
        public let result: ((Date) -> String)
        init(_ result: @escaping ((Date) -> String)) {
            self.result = result
        }
    }

    public struct Representation: RelativeTimeRepresentation {
        public let result: ((Date) -> String)
        public let upTo: Threshold
        init(upTo: Threshold, _ result: @escaping ((Date) -> String)) {
            self.upTo = upTo
            self.result = result
        }
    }

    public struct Configuration<T: RelativeTimeRepresentation> {
        public init(defaultRepresentation: RelativeTimeDefaultRepresentation,
                    representations: [T],
                    now: @escaping (() -> Date) = { Date() }) {
            self.defaultRepresentation = defaultRepresentation
            self.representations = representations
            self.now = now
        }

        public var defaultRepresentation: RelativeTimeDefaultRepresentation
        public var representations:  [T]
        public var now: (() -> Date)
    }
}
