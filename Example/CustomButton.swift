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
            action: context.parameter(name: "action")
        )
    }
    
    static var previews: some View {
        exhibit.preview()
            .previewLayout(.sizeThatFits)
        
        exhibit.preview(parameters: ["title": "Other"])
            .previewLayout(.sizeThatFits)
    }
}

