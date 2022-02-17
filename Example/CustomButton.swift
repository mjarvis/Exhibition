import Exhibition
import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
    }
}

struct CustomButton_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit = Exhibit(name: "CustomButton") { context in
        CustomButton(
            title: context.parameter(name: "title", defaultValue: "Title")
        ) {
            context.log("Button Pressed")
        }
            .previewLayout(.sizeThatFits)
    }
}

