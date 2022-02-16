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
    static var exhibit: Exhibit = Exhibit(name: "CustomDatePicker") { parameters in
        CustomDatePicker(
            title: parameters.constant(name: "title", defaultValue: "Title"),
            date: parameters.binding(name: "date")
        )
    }
}
