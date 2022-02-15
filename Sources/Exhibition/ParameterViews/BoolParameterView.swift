import SwiftUI

extension Toggle: ParameterView where Label == Text {
    public init(key: String, value: Binding<Bool>) {
        self.init(key, isOn: value)
    }
}

typealias BoolParameterView = Toggle
