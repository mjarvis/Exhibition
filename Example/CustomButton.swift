import Exhibition
import SwiftUI

struct CustomButton: View {
    let title: String
    
    var body: some View {
        Button(title) {
            print("Pressed")
        }
    }
}

struct CustomButton_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit = Exhibit(name: "CustomButton") { context in
        CustomButton(
            title: context.parameter(name: "title", defaultValue: "Title")
        )
            .previewLayout(.sizeThatFits)
    }
}

