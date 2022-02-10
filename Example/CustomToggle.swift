import Exhibition
import SwiftUI

struct CustomToggle: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(title, isOn: $isOn)
    }
}

struct CustomToggle_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit = Exhibit(name: "CustomToggle") { parameters in
        CustomToggle(
            title: parameters.constant(name: "title", defaultValue: "Title"),
            isOn: parameters.binding(name: "isOn")
        )
            .previewLayout(.sizeThatFits)
    }
}
