//
//  Inject.swift
//  
//
//  Created by Tatsuya Tanaka on 2019/06/15.
//

import Foundation

@propertyWrapper
public struct Inject<Target, Value> {
    public init(_ type: Target.Type) {}

    public var wrappedValue: Value {
        DIResolver.resolve(Target.self)!
    }
}
