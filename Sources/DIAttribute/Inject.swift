//
//  Inject.swift
//  
//
//  Created by Tatsuya Tanaka on 2019/06/15.
//

import Foundation

@propertyWrapper
public struct Inject<Target, Value> {
    let target: Target.Type

    public init(_ type: Target.Type) {
        target = type
    }

    public var value: Value {
        DIResolver.resolve(target)!
    }
}
