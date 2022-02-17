import SwiftUI

public struct Exhibit: View {
 
    let name: String
    let view: (Context) -> AnyView
    
    @ObservedObject var context = Context()
    
    public init<T: View>(name: String, @ViewBuilder _ builder: @escaping (Context) -> T) {
        self.name = name
        view = { context in AnyView(builder(context)) }
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

