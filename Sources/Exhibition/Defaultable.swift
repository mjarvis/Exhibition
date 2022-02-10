import Foundation

public protocol Defaultable {
    static var defaultValue: Self { get }
}

extension Optional: Defaultable {
    public static var defaultValue: Self { nil }
}

extension String: Defaultable {
    public static var defaultValue: String { "" }
}

extension Int: Defaultable {
    public static var defaultValue: Int { 0 }
}

extension Float: Defaultable {
    public static var defaultValue: Float { 0 }
}

extension Bool: Defaultable {
    public static var defaultValue: Bool { false }
}

extension Array: Defaultable {
    public static var defaultValue: Array<Element> { [] }
}

extension Dictionary: Defaultable {
    public static var defaultValue: Dictionary<Key, Value> { [:] }
}
