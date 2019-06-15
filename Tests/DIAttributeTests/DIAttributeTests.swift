import XCTest
@testable import DIAttribute

private protocol SampleProtocol {
    var stringValue: String { get }
}

private struct Sample: SampleProtocol {
    let stringValue: String
}

final class DIAttributeTests: XCTestCase {
    override func setUp() {
        DIResolver.clear()
    }

    func testInjectPrimitiveType() {
        struct A {
            @Inject(Self.self) var value: Int
        }

        DIResolver.register(A.self, type: Int.self, value: 123)
        XCTAssertEqual(A().value, 123)
    }

    func testInjectProtocol() {
        class A {
            @Inject(A.self) var sample: SampleProtocol
        }

        let sample = Sample(stringValue: "hello")
        DIResolver.register(A.self, keyPath: \.sample, value: sample)
        XCTAssertEqual(A().sample.stringValue, sample.stringValue)
    }

    func testInjectMultiValue() {
        struct A {
            @Inject(Self.self) var value: Int
            @Inject(Self.self) var sample: SampleProtocol
        }

        let sample = Sample(stringValue: "hello")
        DIResolver.register(A.self) {
            Register(Int.self, 123)
            Register(SampleProtocol.self, sample)
        }
        XCTAssertEqual(A().value, 123)
        XCTAssertEqual(A().sample.stringValue, sample.stringValue)
    }

    static var allTests = [
        ("testInjectPrimitiveType", testInjectPrimitiveType),
        ("testInjectProtocol", testInjectProtocol),
        ("testInjectMultiValue", testInjectMultiValue)
    ]
}
