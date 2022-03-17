import SwiftUI

public protocol ExhibitProvider {
    associatedtype Content: View
    associatedtype Layout: View
    
    static var exhibitName: String { get }
    static var exhibitSection: String { get }
    
    static func exhibitContent(context: Context) -> Content
    
    static func exhibitLayout(_ content: Content) -> Layout
}

public extension ExhibitProvider {
    static var exhibitSection: String { "" }
    
    static var exhibit: Exhibit<Content> {
        Exhibit(name: exhibitName, section: exhibitSection, builder: exhibitContent)
    }
    
    static var previews: some View {
        Exhibit(name: exhibitName, section: exhibitSection, builder: exhibitContent)
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
