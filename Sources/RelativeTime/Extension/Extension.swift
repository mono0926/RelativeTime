//
//  Extension.swift
//  RelativeTime
//
//  Created by mono on 2017/05/16.
//
//

import Foundation

public struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionCompatible {
    associatedtype Compatible
    static var rt: Extension<Compatible>.Type { get }
    var rt: Extension<Compatible> { get }
}

extension ExtensionCompatible {
    public static var rt: Extension<Self>.Type {
        return Extension<Self>.self
    }

    public var rt: Extension<Self> {
        return Extension(self)
    }
}
