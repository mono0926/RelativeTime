import Foundation

public struct RelativeTime {
    private init() {}

    public static var defaultConfiguration = Configuration(
        defaultRepresentation: DefaultRepresentation { date in date.rt.digitYearDate },
        representations: Preset.chat1)
}
