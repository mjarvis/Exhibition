import SwiftUI
import Exhibition

struct CustomTextField: View {
    let doublePlaceholder: String
    let floatPlaceholder: String
    
    @Binding var doubleValue: Double
    @Binding var floatValue: Float
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text("Double: ")
                TextField(doublePlaceholder, value: $doubleValue, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            HStack {
                Text("Float: ")
                TextField(floatPlaceholder, value: $floatValue, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
        }
    }
}

struct CustomTextField_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit = Exhibit(name: "CustomTextField") { context in
        CustomTextField(
            doublePlaceholder: context.parameter(name: "doublePlaceholder", defaultValue: "0.0"),
            floatPlaceholder: context.parameter(name: "floatPlaceholder", defaultValue: "0.0"),
            doubleValue: context.parameter(name: "doubleValue", defaultValue: 0.0),
            floatValue: context.parameter(name: "floatValue", defaultValue: 0.0)
        )
    }
    
    static var previews: some View {
        exhibit.preview()
            .previewLayout(.sizeThatFits)
        
        exhibit.preview(parameters: ["floatValue": 1.0])
            .previewLayout(.sizeThatFits)
    }
}
