import SwiftUI

func stringParameterView(key: String, value: Binding<String>) -> some View {
    HStack {
        Text(key)
        TextField(key, text: value)
            .multilineTextAlignment(.trailing)
    }
}

extension Context {
    func parameter(name: String, defaultValue: String) -> String {
        parameter(name: name, defaultValue: defaultValue, view: stringParameterView)
    }
}
