import Exhibition
import SwiftUI

struct CustomSegmentedControl: View {
    let title: String
    @Binding var selection: Option
    
    var body: some View {
        Picker(title, selection: $selection) {
            ForEach(Option.allCases, id: \.rawValue) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    enum Option: String, CaseIterable, CustomDebugStringConvertible {
        case first = "first"
        case second = "second"
        case third = "third"
        
        var debugDescription: String {
            rawValue
        }
    }
}

struct CustomSegmentedControl_Previews: ExhibitProvider, PreviewProvider {
    static var exhibit: Exhibit = Exhibit(
        name: "CustomSegmentedControl",
        section: "Pickers"
    ) { context in
        CustomSegmentedControl(
            title: context.parameter(name: "title", defaultValue: "Title"),
            selection: context.parameter(name: "selection", defaultValue: .first)
        )
    }
}
