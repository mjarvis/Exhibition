import SwiftUI

public struct EnumParameter {
    public typealias EnumType = CaseIterable & CustomDebugStringConvertible & Hashable
    
    var current: AnyHashable
    let cases: [String: AnyHashable]
    
    init<E: EnumType>(value: E) {
        self.current = value
        self.cases = Dictionary(uniqueKeysWithValues: E.allCases.map {
            ($0.debugDescription, $0)
        })
    }
    
    func value<E>() -> E? {
        return current as? E
    }
}


public extension Exhibit.Context {
    func parameter<E: EnumParameter.EnumType>(name: String, defaultValue: E) -> E {
        let parameter: EnumParameter = parameter(
            name: name,
            defaultValue: EnumParameter(value: defaultValue)
        )
        
        return parameter.current as! E
    }
    
    func parameter<E: EnumParameter.EnumType>(name: String, defaultValue: E) -> Binding<E> {
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

public struct EnumParameterView: ParameterView {
    let key: String
    @Binding var value: EnumParameter
    
    public init(key: String, value: Binding<EnumParameter>) {
        self.key = key
        _value = value
    }
    
    public var body: some View {
        Picker(key, selection: $value.current) {
            ForEach(value.cases.sorted(by: keyAscending), id: \.0) { (key, value) in
                Text(key).tag(value)
            }
        }
    }
}
