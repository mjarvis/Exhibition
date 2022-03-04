import SwiftUI

public struct Exhibit<Content: View> {
 
    let name: String
    let section: String
    let content: (Context) -> Content
    
    public init(
        name: String,
        section: String = "",
        @ViewBuilder builder: @escaping (Context) -> Content
    ) {
        self.name = name
        self.section = section
        self.content = builder
    }
}

extension Exhibit {
    @ViewBuilder public func preview(parameters: [String: Any] = [:]) -> some View {
        ExhibitView(
            exhibit: self,
            context: Context(parameters: parameters)
        )
    }
}

struct ExhibitView<Content: View>: View {
    let exhibit: Exhibit<Content>
    @ObservedObject var context: Context
    
    var body: some View {
        exhibit.content(context)
    }
}

public struct AnyExhibit {
    let name: String
    let section: String
    let content: (Context) -> AnyView
    
    init<Content: View, Layout: View>(_ exhibit: Exhibit<Content>, layout: @escaping (Content) -> Layout) {
        self.name = exhibit.name
        self.section = exhibit.section
        self.content = { context in
            AnyView(layout(exhibit.content(context)))
        }
    }
}

extension AnyExhibit: Identifiable {
    public var id: String {
        name
    }
}

struct AnyExhibitView: View {
    let exhibit: AnyExhibit
    @ObservedObject var context: Context
    
    var body: some View {
        exhibit.content(context)
    }
}
