import SwiftUI

public struct EnumParameterView<Value: CaseIterable & CustomDebugStringConvertible & Hashable>: ParameterView {
    let key: String
    @Binding var value: Value
    
    public init(key: String, value: Binding<Value>) {
        self.key = key
        _value = value
    }
    
    public var body: some View {
        Picker(key, selection: $value) {
            ForEach(Array(Value.allCases), id: \.debugDescription) { option in
                Text(option.debugDescription).tag(option)
            }
        }
    }
}
