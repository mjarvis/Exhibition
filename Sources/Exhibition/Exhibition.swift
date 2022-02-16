import SwiftUI

public struct Exhibition: View {

    let exhibits: [Exhibit]

    @State var displayed: AnyHashable?
    @State var debugViewPresented: Bool = false
    @State var searchText = ""

    // MARK: Accessibility
    @State var preferredColorScheme: ColorScheme = .light
    @State var layoutDirection: LayoutDirection = .leftToRight

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
            List(searchResults) { exhibit in
                NavigationLink(exhibit.id, destination: debuggable(exhibit))
            }
            .searchable(text: $searchText)
            .navigationTitle("Exhibit")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(preferredColorScheme)
        .environment(\.layoutDirection, layoutDirection)
    }
    
    private func debuggable(_ exhibit: Exhibit) -> some View {
        exhibit
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        debugViewPresented = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $debugViewPresented) {
                DebugView(
                    parameters: exhibit.parameters,
                    preferredColorScheme: $preferredColorScheme,
                    layoutDirection: $layoutDirection
                )
            }
            .parameterView(StringParameterView.self)
            .parameterView(BoolParameterView.self)
            .parameterView(IntParameterView.self)
            .parameterView(DateParameterView.self)
    }
    
    private var searchResults: [Exhibit] {
        if searchText.isEmpty {
            return exhibits
        } else {
            return exhibits.filter {
                $0.id.localizedCaseInsensitiveContains(searchText)
            }
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
