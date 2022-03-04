import SwiftUI

public struct ExhibitListView: View {

    let exhibits: [AnyExhibit]

    @State var displayed: AnyHashable?
    @State var rootDebugViewPresented: Bool = false
    @State var exhibitDebugViewPresented: Bool = false
    @State var searchText = ""

    // MARK: Accessibility
    @State var preferredColorScheme: ColorScheme = .light
    @State var layoutDirection: LayoutDirection = .leftToRight
    
    private var sections: [String: [AnyExhibit]] {
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

    public init(exhibits: [AnyExhibit]) {
        self.exhibits = exhibits
    }
    
    public var body: some View {
        List(sections.sorted(by: keyAscending), id: \.key) { section in
            if section.key.isEmpty {
                ForEach(section.value) { exhibit in
                    NavigationLink(exhibit.id, destination: debuggable(exhibit))
                }
            } else {
                Section {
                    ForEach(section.value) { exhibit in
                        NavigationLink(exhibit.id, destination: debuggable(exhibit))
                    }
                } header: {
                    Text(section.key)
                }
            }
        }
        .modify {
            if #available(macOS 12.0, *) {
                $0.searchable(text: $searchText)
            } else {
                $0
            }
        }
        .navigationTitle("Exhibit")
        .toolbar {
            ToolbarItem {
                Button {
                    rootDebugViewPresented = true
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $rootDebugViewPresented) {
            DebugView(
                context: .init(),
                preferredColorScheme: $preferredColorScheme,
                layoutDirection: $layoutDirection
            )
        }
        .preferredColorScheme(preferredColorScheme)
        .environment(\.layoutDirection, layoutDirection)
    }
    
    private func debuggable(_ exhibit: AnyExhibit) -> some View {
        let context = Context()
        return AnyExhibitView(exhibit: exhibit, context: context)
            .toolbar {
                ToolbarItem {
                    Button {
                        exhibitDebugViewPresented = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $exhibitDebugViewPresented) {
                DebugView(
                    context: context,
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
    
    private var searchResults: [AnyExhibit] {
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

struct ExhibitListView_Previews: PreviewProvider {
    struct First: ExhibitProvider {
        static let exhibit = Exhibit(name: "Text", section: "Section 1") { context in
            Text(context.parameter(name: "Content", defaultValue: "Text"))
        }
    }
    
    struct Second: ExhibitProvider {
        static let exhibit = Exhibit(name: "Text", section: "Section 1") { context in
            Text(context.parameter(name: "Content", defaultValue: "Text"))
        }
    }
    
    static var previews: some View {
        ExhibitListView(
            exhibits: [
                First.anyExhibit,
                Second.anyExhibit,
            ]
        )
    }
}
