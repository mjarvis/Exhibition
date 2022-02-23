import SwiftUI

public struct Exhibit: View {
 
    let name: String
    let section: String
    let view: (Context) -> AnyView
    let layout: (Self) -> AnyView

    @ObservedObject var context = Context()
    
    public init<T: View, S: View>(
        name: String,
        section: String = "",
        @ViewBuilder builder: @escaping (Context) -> T,
        @ViewBuilder layout: @escaping (Self) -> S
    ) {
        self.name = name
        self.section = section
        view = { context in AnyView(builder(context)) }
        self.layout = { exhibit in AnyView(layout(exhibit)) }
    }
    
    public var body: some View {
        view(context)
            .navigationTitle(name)
    }
}

extension Exhibit: Identifiable {
    public var id: String {
        name
    }
}

extension Exhibit {
    public init<T: View>(
        name: String,
        section: String = "",
        @ViewBuilder builder: @escaping (Context) -> T
    ) {
        self.init(
            name: name,
            section: section,
            builder: builder
        ) { AnyView($0) }
    }
}
