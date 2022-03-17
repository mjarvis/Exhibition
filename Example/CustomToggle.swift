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
    static var exhibitName: String = "CustomToggle"
    
    static func exhibitContent(context: Context) -> CustomToggle {
        CustomToggle(
            title: context.parameter(name: "title", defaultValue: "Title"),
            isOn: context.parameter(name: "isOn")
        )
    }
    
    static func exhibitLayout(_ content: CustomToggle) -> some View {
        content.padding()
    }
}
