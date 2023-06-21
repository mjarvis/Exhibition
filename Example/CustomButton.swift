import Exhibition
import SwiftUI

struct CustomButton: View {
    let title: String
    let action: (Date) -> Void
    
    var body: some View {
        Button(title) {
            action(Date())
        }
    }
}

struct CustomButton_Previews: ExhibitProvider, PreviewProvider {
    static var exhibitName: String = "CustomButton"
    
    static func exhibitContent(context: Context) -> some View {
        CustomButton(
            title: context.parameter(name: "title", defaultValue: "Title"),
            action: { _ in }
        )
    }
    
    static var previews: some View {
        exhibitPreview()
            .previewLayout(.sizeThatFits)
        
        exhibitPreview(parameters: ["title": "Other"])
            .previewLayout(.sizeThatFits)
    }
}

