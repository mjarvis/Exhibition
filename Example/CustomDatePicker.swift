import SwiftUI
import Exhibition

struct CustomDatePicker: View {
    let title: String
    @Binding var date: Date
    
    var body: some View {
        DatePicker(title, selection: $date)
    }
}

struct CustomDatePicker_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit = Exhibit(
        name: "CustomDatePicker",
        section: "Pickers"
    ) { context in
        CustomDatePicker(
            title: context.parameter(name: "title", defaultValue: "Title"),
            date: context.parameter(name: "date")
        )
    }
}
