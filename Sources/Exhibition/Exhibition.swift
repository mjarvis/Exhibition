import SwiftUI

//public struct Exhibition: View {
//
//    let exhibits: [Exhibit]
//
////    let navigation: [AnyHashable:Bool]
//    @State var displayed: AnyHashable?
//
//    func displayBinding(for id: AnyHashable) -> Binding<Bool> {
//        Binding(
//            get: { displayed == id },
//            set: { newValue in
//                if newValue {
//                    displayed = id
//                } else {
//                    displayed = nil
//                }
//            }
//        )
//    }
//
//    public init(exhibits: [Exhibit]) {
//        self.exhibits = exhibits
//    }
//
//    public var body: some View {
//        NavigationView {
//            List(exhibits) { exhibit in
//                NavigationLink(exhibit.id, destination: exhibit.view)
//            }
//            .navigationTitle("Exhibit")
//        }
//    }
//}
//
//public enum Display {
//    case push
//    case present
//}
//
//public struct Component: Identifiable {
//
//    public let id: String
//
//    let view: AnyView
//    let display: Display
//
//    public init<T: View>(title: String, view: T, display: Display = .push) {
//        self.id = title
//        self.view = AnyView(view)
//        self.display = display
//    }
//}
//
//public protocol ExhibitionComponentProvider {
//    static var components: [Component] { get }
//}
//
//extension ExhibitionComponentProvider where Self: PreviewProvider {
//    static var previews: some View {
//        ForEach(components) { component in
//            component.view
//        }
//    }
//}
//
//struct Exhibition_Previews: PreviewProvider {
//    static var previews: some View {
//        Exhibition(
//            components: [
//                .init(title: "Text", view: Text("FooBar"))
//            ]
//        )
//
//        GroupBox {
//            GroupBox {
//                GroupBox {
//                    Text("sgsdgsdgfgdfg")
//                }
//            }
//        }
//        .previewLayout(.sizeThatFits)
//
//        GroupBox {
//            VStack {
//                GroupBox {
//                    Text("sgsdgsdgfgdfg")
//                }
//            }
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
