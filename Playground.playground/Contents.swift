//: Playground - noun: a place where people can play

import Cocoa
import RelativeTime

// Default
let now = Date()
now.rt.relative // "Just now"
now.addingTimeInterval(-1000).rt.relative
now.addingTimeInterval(-100000).rt.relative
now.addingTimeInterval(-1000000).rt.relative
now.addingTimeInterval(-10000000).rt.relative
now.addingTimeInterval(-100000000).rt.relative

// Use other preset
RelativeTime.defaultConfiguration.representations = Preset.JoinUs.usersList
now.rt.relative // Not "Just now"

// Use custom
struct MyDefault: DefaultRepresentationProtocol {
    var representation: ((Date, Bundle) -> String) { return { date, _ in "defaultの\(date)(　´･‿･｀)" } }
}
struct MyRepresentation: ThresholdRepresentationProtocol {
    var representation: ((Date, Bundle) -> String) { return { date, _ in "\(date)(　´･‿･｀)" } }
    var upTo: MyThreshold { return MyThreshold() }

}
struct MyThreshold: ThresholdProtocol {
    func within(date: Date, now: Date) -> Bool { return true }
}
let config = Configuration(defaultRepresentation: MyDefault(),
                           representations: [MyRepresentation()])
now.rt.relative(config)

RelativeTime.defaultConfiguration.defaultRepresentation = MyDefault()
now.addingTimeInterval(-100000000).rt.relative