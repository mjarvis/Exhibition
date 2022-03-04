import SwiftUI

public protocol ExhibitProvider {
    associatedtype Content: View
    associatedtype Layout: View
    
    static var exhibit: Exhibit<Content> { get }
    
    static func exhibitLayout(_ content: Content) -> Layout
}

public extension ExhibitProvider {
    static var previews: some View {
        exhibit
            .preview()
            .previewLayout(.sizeThatFits)
    }
    
    static var anyExhibit: AnyExhibit {
        AnyExhibit(exhibit, layout: exhibitLayout)
    }
}

public extension ExhibitProvider where Content == Layout {
    static func exhibitLayout(_ content: Content) -> Layout {
        content
    }
}
