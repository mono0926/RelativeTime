//
//  Representation.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

public protocol DefaultRepresentationProtocol {
    var representation: ((Date, Bundle) -> String) { get }
}
public protocol ThresholdRepresentationProtocol: DefaultRepresentationProtocol {
    associatedtype Threshold: ThresholdProtocol
    var upTo: Threshold { get }
}

public struct DefaultRepresentation: DefaultRepresentationProtocol {
    public let representation: ((Date, Bundle) -> String)
    init(_ representation: @escaping ((Date, Bundle) -> String)) {
        self.representation = representation
    }
}

public struct ThresholdRepresentation: ThresholdRepresentationProtocol {
    public let representation: ((Date, Bundle) -> String)
    public let upTo: Threshold
    init(upTo: Threshold, _ representation: @escaping ((Date, Bundle) -> String)) {
        self.upTo = upTo
        self.representation = representation
    }
}
