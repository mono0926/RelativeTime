//: Playground - noun: a place where people can play

import Cocoa
import RelativeTime

// Default
let now = Date()
now.rt.relativeTime // "Just now"
now.addingTimeInterval(-1000).rt.relativeTime
now.addingTimeInterval(-100000).rt.relativeTime
now.addingTimeInterval(-1000000).rt.relativeTime
now.addingTimeInterval(-10000000).rt.relativeTime
now.addingTimeInterval(-100000000).rt.relativeTime

// Use other preset
RelativeTime.defaultConfiguration.representations = RelativeTime.Preset.chat2
now.rt.relativeTime // Not "Just now"

// Use custom
struct MyDefault: RelativeTimeDefaultRepresentation {
    var result: ((Date) -> String) { return { date in "defaultの\(date)(　´･‿･｀)" } }
}
struct MyRepresentation: RelativeTimeRepresentation {
    var result: ((Date) -> String) { return { date in "\(date)(　´･‿･｀)" } }
    var upTo: MyThreshold { return MyThreshold() }

}
struct MyThreshold: RelativeTimeThreshold {
    func within(date: Date, now: Date) -> Bool { return true }
}
let config = RelativeTime.Configuration(defaultRepresentation: MyDefault(),
                                    representations: [MyRepresentation()])
now.rt.relativeTime(config)

RelativeTime.defaultConfiguration.defaultRepresentation = MyDefault()
now.addingTimeInterval(-100000000).rt.relativeTime