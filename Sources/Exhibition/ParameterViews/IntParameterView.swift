import SwiftUI

extension Stepper: ParameterView where Label == Text {
    public init(key: String, value: Binding<Int>) {
        self.init(key, value: value)
    }
}

typealias IntParameterView = Stepper
