import SwiftUI

struct StringParameterView: ParameterView {
    let key: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(key)
            TextField(key, text: $value)
                .multilineTextAlignment(.trailing)
        }
    }
}
