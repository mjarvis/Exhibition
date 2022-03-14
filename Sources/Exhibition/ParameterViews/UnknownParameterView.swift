import SwiftUI

/// View displayed when a matching parameter view is not found.
struct UnknownParameterView: ParameterView {
    let key: String
    @Binding var value: Any
    
    var body: some View {
        Text("\(key): \(String(describing: type(of: value)))")
    }
}
