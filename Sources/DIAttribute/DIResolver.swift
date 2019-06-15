//
//  DIResolver.swift
//
//
//  Created by Tatsuya Tanaka on 2019/06/15.
//

import Foundation

public struct DIResolver {
    public typealias Factory<Value> = () -> Value

    private static var factories: [ObjectIdentifier: [ObjectIdentifier: Factory<Any>]] = [:]

    public static func register<Target, Value>(
        _ target: Target.Type = Target.self,
        type: Value.Type,
        value: @autoclosure @escaping Factory<Value>) {
        let targetKey = ObjectIdentifier(target)
        let valueKey = ObjectIdentifier(Value.self)
        register(targetKey: targetKey, valueKey: valueKey, value: value)
    }

    public static func register<Target, Value>(
        _ target: Target.Type = Target.self,
        keyPath: KeyPath<Target, Value>,
        value: @autoclosure @escaping Factory<Value>) {
        let targetKey = ObjectIdentifier(target)
        let valueKey = ObjectIdentifier(Value.self)
        register(targetKey: targetKey, valueKey: valueKey, value: value)
    }

    public static func register<Target>(
        _ target: Target.Type = Target.self,
        @RegisterBuilder registerBuilder: () -> [Register]) {
        let targetKey = ObjectIdentifier(target)
        for register in registerBuilder() {
            self.register(targetKey: targetKey, valueKey: register.key, value: register.value)
        }
    }

    private static func register(
        targetKey: ObjectIdentifier,
        valueKey: ObjectIdentifier,
        value: @escaping Factory<Any>) {
        if factories[targetKey] == nil {
            factories[targetKey] = [valueKey: value]
        } else {
            factories[targetKey]![valueKey] = value
        }
    }

    public static func resolve<Target, Value>(
        _ target: Target.Type = Target.self,
        value: Value.Type = Value.self) -> Value? {
        factories[.init(target)]?[.init(value)]?() as? Value
    }

    public static func clear() {
        factories = [:]
    }
}
