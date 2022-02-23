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
    static var exhibit = Exhibit(name: "CustomToggle") { context in
        CustomToggle(
            title: context.parameter(name: "title", defaultValue: "Title"),
            isOn: context.parameter(name: "isOn")
        )
    } layout: { exhibit in
        exhibit
            .padding()
    }
}
