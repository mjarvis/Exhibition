import Exhibition
import SwiftUI

struct CustomPopover: View {
    let contents: String
    
    var body: some View {
        Text(contents)
    }
}

struct CustomPopover_Previews: PreviewProvider, ExhibitProvider {
    static var exhibit: Exhibit = Exhibit(
        name: "CustomPopover",
        layout: Layout.init(exhibit:)
    ) { context in
        CustomPopover(
            contents: context.parameter(name: "contents", defaultValue: "Contents")
        )
    }
    
    struct Layout: View {
        let exhibit: Exhibit
        
        init(exhibit: Exhibit) {
            self.exhibit = exhibit
        }
        
        @State var popover: Bool = false
        
        var body: some View {
            Button("Open Popover") {
                popover = true
            }
            .popover(isPresented: $popover) {
                exhibit
            }
        }
    }
}
