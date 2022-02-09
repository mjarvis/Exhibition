import SwiftUI

public protocol ExhibitProvider {
    static var exhibits: [Exhibit] { get }
    static var name: String { get }
}

public extension ExhibitProvider {
    
    static var previews: some View {
        ForEach(exhibits) { exhibit in
            exhibit
        }
    }
    
    static var name: String {
        String(describing: Self.self)
    }
}
