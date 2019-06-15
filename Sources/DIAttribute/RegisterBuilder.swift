//
//  RegisterBuilder.swift
//  
//
//  Created by Tatsuya Tanaka on 2019/06/15.
//

import Foundation

public struct Register {
    let key: ObjectIdentifier
    let value: () -> Any

    public init<T>(_ type: T.Type, _ value: @autoclosure @escaping () -> T) {
        key = ObjectIdentifier(type)
        self.value = value
    }
}

@_functionBuilder public struct RegisterBuilder {
    public static func buildBlock(
        _ registers: Register...
        ) -> [Register] {
        registers
    }
}
