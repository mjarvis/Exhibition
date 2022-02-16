import SwiftUI

extension DatePicker: ParameterView where Label == Text {
    public init(key: String, value: Binding<Date>) {
        self.init(key, selection: value)
    }
}

typealias DateParameterView = DatePicker
