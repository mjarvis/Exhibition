import SwiftUI

public struct ExhibitListView: View {

    let exhibits: [Exhibit]

    @State var displayed: AnyHashable?
    @State var rootDebugViewPresented: Bool = false
    @State var exhibitDebugViewPresented: Bool = false
    @State var searchText = ""

    // MARK: Accessibility
    @State var preferredColorScheme: ColorScheme = .light
    @State var layoutDirection: LayoutDirection = .leftToRight
    
    @Environment(\.presentationMode) var presentationMode
    
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
        .if(presentationMode.wrappedValue.isPresented) {
            $0.toolbar {
                #if !os(macOS) && !os(watchOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                #endif
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
    
    private func debuggable(_ exhibit: Exhibit) -> some View {
        exhibit.layout(exhibit)
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

struct ExhibitListView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitListView(
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