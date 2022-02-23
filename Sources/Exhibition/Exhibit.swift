import SwiftUI

public struct Exhibit: View {
 
    let name: String
    let section: String
    let view: (Context) -> AnyView
    
    @ObservedObject var context = Context()
    
    public init<T: View>(name: String, section: String = "", @ViewBuilder _ builder: @escaping (Context) -> T) {
        self.name = name
        self.section = section
        view = { parameters in AnyView(builder(context)) }
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

