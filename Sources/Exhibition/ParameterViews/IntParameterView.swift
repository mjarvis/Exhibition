import SwiftUI

#if os(watchOS)

extension Slider: ParameterView where ValueLabel == EmptyView, Label == Text {
    public init(key: String, value: Binding<Int>) {
        self.init(
            value: Binding(
                get: { Float(value.wrappedValue) },
                set: { value.wrappedValue = Int($0) }
            ),
            label: {
                Text(key)
            }
        )
    }
}

typealias IntParameterView = Slider

#else

extension Stepper: ParameterView where Label == Text {
    public init(key: String, value: Binding<Int>) {
        self.init(key, value: value)
    }
}

typealias IntParameterView = Stepper

#endif
