import SwiftUI

struct DoubleParameterView: ParameterView {
    let key: String
    @Binding var value: Double
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack {
            Text(key)
            TextField(key, value: $value, formatter: formatter)
                .multilineTextAlignment(.trailing)
        }
    }
}


