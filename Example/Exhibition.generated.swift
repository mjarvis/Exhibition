// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Exhibition
import SwiftUI

public struct Exhibition: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            ExhibitListView(
                exhibits: [
                    CustomButton_Previews.anyExhibit(sample: """
                     Optional("Exhibit(name: \"CustomButton\") { context in\n        CustomButton(\n            title: context.parameter(name: \"title\", defaultValue: \"Title\"),\n            action: context.parameter(name: \"action\")\n        )\n    }")
                    """),
                    CustomDatePicker_Previews.anyExhibit(sample: """
                     Optional("Exhibit(\n        name: \"CustomDatePicker\",\n        section: \"Pickers\"\n    ) { context in\n        CustomDatePicker(\n            title: context.parameter(name: \"title\", defaultValue: \"Title\"),\n            date: context.parameter(name: \"date\")\n        )\n    }")
                    """),
                    CustomSegmentedControl_Previews.anyExhibit(sample: """
                     Optional("Exhibit(\n        name: \"CustomSegmentedControl\",\n        section: \"Pickers\"\n    ) { context in\n        CustomSegmentedControl(\n            title: context.parameter(name: \"title\", defaultValue: \"Title\"),\n            selection: context.parameter(name: \"selection\", defaultValue: .first)\n        )\n    }")
                    """),
                    CustomTextField_Previews.anyExhibit(sample: """
                     Optional("Exhibit(name: \"CustomTextField\") { context in\n        CustomTextField(\n            doublePlaceholder: context.parameter(name: \"doublePlaceholder\", defaultValue: \"0.0\"),\n            floatPlaceholder: context.parameter(name: \"floatPlaceholder\", defaultValue: \"0.0\"),\n            doubleValue: context.parameter(name: \"doubleValue\", defaultValue: nil),\n            floatValue: context.parameter(name: \"floatValue\", defaultValue: nil)\n        )\n    }")
                    """),
                    CustomToggle_Previews.anyExhibit(sample: """
                     Optional("Exhibit(name: \"CustomToggle\") { context in\n        CustomToggle(\n            title: context.parameter(name: \"title\", defaultValue: \"Title\"),\n            isOn: context.parameter(name: \"isOn\")\n        )\n    }")
                    """),
                ]
            )
        }
    }
}

struct Exhibition_Previews: PreviewProvider {
    static var previews: some View {
        Exhibition()
    }
}
