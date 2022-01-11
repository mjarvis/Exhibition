import SwiftUI

public struct Exhibit: View {
    
    let components: [Component]
    
//    let navigation: [AnyHashable:Bool]
    @State var displayed: AnyHashable?
    
    func displayBinding(for id: AnyHashable) -> Binding<Bool> {
        Binding(
            get: { displayed == id },
            set: { newValue in
                if newValue {
                    displayed = id
                } else {
                    displayed = nil
                }
            }
        )
    }
    
    public init(components: [Component]) {
        self.components = components
    }
    
    public var body: some View {
        NavigationView {
            List(components) { component in
                NavigationLink(component.id, destination: component.view)
            }
            .navigationTitle("Exhibit")
        }
    }
}

public enum Display {
    case push
    case present
}

public struct Component: Identifiable {
    
    public let id: String
    
    let view: AnyView
    let display: Display
    
    public init<T: View>(title: String, view: T, display: Display = .push) {
        self.id = title
        self.view = AnyView(view)
        self.display = display
    }
}

struct Exhibit_Previews: PreviewProvider {
    static var previews: some View {
        Exhibit(
            components: [
                .init(title: "Text", view: Text("FooBar"))
            ]
        )
    }
}
