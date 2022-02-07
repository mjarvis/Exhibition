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

struct CustomButton_Previews: Exhibit, PreviewProvider {
    static var items: [Item] = [
        Item(
            variant: "primary",
            view: CustomButton(title: "Primary")
        )
    ]
}
