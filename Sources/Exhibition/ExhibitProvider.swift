import SwiftUI

public protocol ExhibitProvider {
    static var items: [Item] { get }
    static var name: String { get }
}

public extension ExhibitProvider {
    
    static var previews: some View {
        ForEach(items) { item in
            item.view
        }
    }
    
    static var name: String {
        String(describing: Self.self)
    }
}
