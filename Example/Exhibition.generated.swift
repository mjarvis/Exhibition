// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Exhibition
import SwiftUI

public struct Exhibition: View {
    public var body: some View {
        NavigationView {
            ExhibitListView(
                exhibits: [
                    CustomButton_Previews.exhibit,
                    CustomDatePicker_Previews.exhibit,
                    CustomToggle_Previews.exhibit,
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
