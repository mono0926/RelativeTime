//
//  Representation.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

public typealias RepresentationType = ((Date, Bundle) -> String)

public protocol DefaultRepresentationProtocol {
    var representation: RepresentationType { get }
}
public protocol ThresholdRepresentationProtocol: DefaultRepresentationProtocol {
    associatedtype Threshold: ThresholdProtocol
    var upTo: Threshold { get }
}

public struct DefaultRepresentation: DefaultRepresentationProtocol {
    public let representation: RepresentationType
    init(_ representation: @escaping RepresentationType) {
        self.representation = representation
    }
}

public struct ThresholdRepresentation: ThresholdRepresentationProtocol {
    public let representation: RepresentationType
    public let upTo: Threshold
    init(upTo: Threshold, _ representation: @escaping RepresentationType) {
        self.upTo = upTo
        self.representation = representation
    }
}
