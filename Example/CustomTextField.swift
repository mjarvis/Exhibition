import SwiftUI
import Exhibition

struct CustomTextField: View {
    let doublePlaceholder: String
    let floatPlaceholder: String
    
    @Binding var doubleValue: Double?
    @Binding var floatValue: Float?
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        #if os(iOS)
            contents
                .keyboardType(.decimalPad)
        #else
            contents
        #endif
    }
    
    @ViewBuilder var contents: some View {
        VStack {
            HStack {
                Text("Double: ")
                TextField(doublePlaceholder, value: $doubleValue, formatter: formatter)
            }
            HStack {
                Text("Float: ")
                TextField(floatPlaceholder, value: $floatValue, formatter: formatter)
            }
        }
    }
}

struct CustomTextField_Previews: ExhibitProvider, PreviewProvider {
    static var exhibitName: String = "CustomTextField"
    
    static func exhibitContent(context: Context) -> some View {
        CustomTextField(
            doublePlaceholder: context.parameter(name: "doublePlaceholder", defaultValue: "0.0"),
            floatPlaceholder: context.parameter(name: "floatPlaceholder", defaultValue: "0.0"),
            doubleValue: context.parameter(name: "doubleValue", defaultValue: nil),
            floatValue: context.parameter(name: "floatValue", defaultValue: nil)
        )
    }
    
    static var previews: some View {
        exhibitPreview()
            .previewLayout(.sizeThatFits)
        
        exhibitPreview(parameters: ["floatValue": 1.0])
            .previewLayout(.sizeThatFits)
    }
}
