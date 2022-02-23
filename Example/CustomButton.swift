import Exhibition
import SwiftUI

struct CustomButton: View {
    let title: String
    let action: (Date) -> Void
    
    var body: some View {
        Button(title) {
            action(.now)
        }
    }
}

struct CustomButton_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit = Exhibit(name: "CustomButton") { context in
        CustomButton(
            title: context.parameter(name: "title", defaultValue: "Title"),
            action: context.parameter(name: "action")
        )
            .previewLayout(.sizeThatFits)
    }
}

