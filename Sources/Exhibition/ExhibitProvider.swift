import SwiftUI

public protocol ExhibitProvider {
    static var exhibit: Exhibit { get }
}

public extension ExhibitProvider {
    static var previews: some View {
        exhibit
    }
}
