import SwiftUI
import Exhibition

struct CustomTextField: View {
    let title: String
    
    @State var valueFloat: Float = 0.0
    @State var valueDouble: Double = 0.0
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack {
            TextField("Input a Float value", value: $valueFloat, formatter: formatter)
            TextField("Input a Double value", value: $valueDouble, formatter: formatter)
        }
    }
}

struct CustomTextField_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit = Exhibit(name: "CustomTextField") { context in
        CustomTextField(
            title: context.parameter(name: "title", defaultValue: "Title"),
            valueFloat: context.parameter(name: "valueFloat", defaultValue: 0.0),
            valueDouble: context.parameter(name: "valueDouble", defaultValue: 0.0)
        )
    }
    
    static var previews: some View {
        exhibit.preview()
            .previewLayout(.sizeThatFits)
        exhibit.preview(parameters: ["valueFloat": 1.0])
            .previewLayout(.sizeThatFits)
    }
}
