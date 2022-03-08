import SwiftUI

public extension Context {
    /// Helper enum to avoid repetition of protocols below
    typealias EnumType = CaseIterable & CustomDebugStringConvertible & Hashable
    
    /// Create a constant parameter for a selectable Enum
    /// - Parameters:
    ///   - name: The debug description name for the parameter.
    ///   - defaultValue: The initial case for the enum.
    /// - Returns: The currently selected case of the enum
    func parameter<E: EnumType>(name: String, defaultValue: E) -> E {
        let parameter: EnumParameter = parameter(
            name: name,
            defaultValue: EnumParameter(value: defaultValue)
        )
        
        return parameter.current as! E
    }
    
    /// Create a binding parameter for a selectable enum
    /// - Parameters:
    ///   - name: The debug description name for the parameter.
    ///   - defaultValue: The initial case for the enum.
    /// - Returns: A binding for the currently selected case of the enum
    func parameter<E: EnumType>(name: String, defaultValue: E) -> Binding<E> {
        let parameter: Binding<EnumParameter> = parameter(
            name: name,
            defaultValue: EnumParameter(value: defaultValue)
        )
        
        return Binding(
            get: { parameter.wrappedValue.current as! E },
            set: { parameter.wrappedValue.current = $0 }
        )
    }
}

/// A parameter representing a selectable Enum
struct EnumParameter {
    var current: AnyHashable
    let cases: [String: AnyHashable]
    
    init<E: Context.EnumType>(value: E) {
        self.current = value
        self.cases = Dictionary(uniqueKeysWithValues: E.allCases.map {
            ($0.debugDescription, $0)
        })
    }
    
    func value<E>() -> E? {
        return current as? E
    }
}

/// Debug parameter row for `EnumParameter`
struct EnumParameterView: ParameterView {
    let key: String
    @Binding var value: EnumParameter
    
    public var body: some View {
        Picker(key, selection: $value.current) {
            ForEach(value.cases.sorted(by: keyAscending), id: \.0) { (key, value) in
                Text(key).tag(value)
            }
        }
    }
}
