//
//  Configuration.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

public struct Configuration<T: ThresholdRepresentationProtocol> {

    public var defaultRepresentation: DefaultRepresentationProtocol
    public var representations:  [T]
    public var now: (() -> Date)
    
    public init(defaultRepresentation: DefaultRepresentationProtocol,
                representations: [T],
                now: @escaping (() -> Date) = { Date() }) {
        self.defaultRepresentation = defaultRepresentation
        self.representations = representations
        self.now = now
    }
}
