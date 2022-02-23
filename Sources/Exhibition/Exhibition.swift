import SwiftUI

public struct Exhibition: View {

    let exhibits: [Exhibit]

    @State var displayed: AnyHashable?
    @State var debugViewPresented: Bool = false
    @State var searchText = ""

    // MARK: Accessibility
    @State var preferredColorScheme: ColorScheme = .light
    @State var layoutDirection: LayoutDirection = .leftToRight
    
    private var sections: [String: [Exhibit]] {
        Dictionary(grouping: searchResults, by: \.section)
    }

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
            List(sections.sorted(by: keyAscending), id: \.key) { section in
                if section.key.isEmpty {
                    ForEach(section.value) { exhibit in
                        NavigationLink(exhibit.id, destination: debuggable(exhibit))
                    }
                } else {
                    Section(section.key) {
                        ForEach(section.value) { exhibit in
                            NavigationLink(exhibit.id, destination: debuggable(exhibit))
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Exhibit")
            .navigationBarTitleDisplayMode(.inline)
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
                    context: .init(),
                    preferredColorScheme: $preferredColorScheme,
                    layoutDirection: $layoutDirection
                )
            }
        }
        .preferredColorScheme(preferredColorScheme)
        .environment(\.layoutDirection, layoutDirection)
    }
    
    private func debuggable(_ exhibit: Exhibit) -> some View {
        exhibit.layout(exhibit)
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
                    context: exhibit.context,
                    preferredColorScheme: $preferredColorScheme,
                    layoutDirection: $layoutDirection
                )
            }
            .parameterView(StringParameterView.self)
            .parameterView(BoolParameterView.self)
            .parameterView(IntParameterView.self)
            .parameterView(DateParameterView.self)
            .parameterView(ClosureParameterView.self)
    }
    
    private var searchResults: [Exhibit] {
        if searchText.isEmpty {
            return exhibits
        } else {
            return exhibits.filter {
                $0.id.localizedCaseInsensitiveContains(searchText) ||
                $0.section.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

struct Exhibition_Previews: PreviewProvider {
    static var previews: some View {
        Exhibition(
            exhibits: [
                .init(name: "Text", section: "Section 1") { context in
                    Text(context.parameter(name: "Content", defaultValue: "Text"))
                },
                .init(name: "Text2", section: "Section 2") { context in
                    Text(context.parameter(name: "Content", defaultValue: "Text"))
                }
            ]
        )
    }
}
