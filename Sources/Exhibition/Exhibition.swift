import SwiftUI

public struct Exhibition: View {

    let exhibits: [Exhibit]

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

    public init(exhibits: [Exhibit]) {
        self.exhibits = exhibits
    }

    public var body: some View {
        NavigationView {
            List(exhibits) { exhibit in
                NavigationLink(exhibit.id, destination: exhibit)
            }
            .navigationTitle("Exhibit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Exhibition_Previews: PreviewProvider {
    static var previews: some View {
        Exhibition(
            exhibits: [
                .init(name: "Text") { parameters in
                    Text(parameters.constant(name: "Content", defaultValue: "Text"))
                }
            ]
        )

        GroupBox {
            GroupBox {
                GroupBox {
                    Text("sgsdgsdgfgdfg")
                }
            }
        }
        .previewLayout(.sizeThatFits)

        GroupBox {
            VStack {
                GroupBox {
                    Text("sgsdgsdgfgdfg")
                }
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
