// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Exhibition
import SwiftUI

public struct Exhibition: View {
    public var body: some View {
        NavigationView {
            ExhibitListView(
                exhibits: [
                    CustomButton_Previews.anyExhibit,
                    CustomDatePicker_Previews.anyExhibit,
                    CustomToggle_Previews.anyExhibit,
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
