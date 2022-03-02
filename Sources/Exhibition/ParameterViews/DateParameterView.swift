import SwiftUI

#if os(watchOS)

struct DateParameterView: ParameterView {
    let key: String
    @Binding var value: Date

    var body: some View {
        HStack {
            Text(key)
            
            Spacer()
            
            Text(value.formatted())
        }
    }
}

#else

extension DatePicker: ParameterView where Label == Text {
    public init(key: String, value: Binding<Date>) {
        self.init(key, selection: value)
    }
}

typealias DateParameterView = DatePicker

#endif
