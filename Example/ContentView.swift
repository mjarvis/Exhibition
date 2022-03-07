import SwiftUI
import Exhibition

struct ContentView: View {
    var body: some View {
        Exhibition()
            .parameterView(EnumParameterView<CustomSegmentedControl.Option>.self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
