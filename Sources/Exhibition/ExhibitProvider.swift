import SwiftUI

public protocol ExhibitProvider {
    associatedtype Content: View
    associatedtype Layout: View
    
    static var exhibitName: String { get }
    static var exhibitSection: String { get }
    
    static func exhibitContent(context: Context) -> Content
    
    static func exhibitLayout(content: Content) -> Layout
}

public extension ExhibitProvider {
    static var exhibitSection: String { "" }
    
    
    @ViewBuilder static func exhibitPreview(parameters: [String: Any] = [:]) -> some View {
        ExhibitPreview(
            builder: exhibitContent,
            context: Context(parameters: parameters)
        )
    }
    
    static var previews: some View {
        exhibitPreview()
            .previewLayout(.sizeThatFits)
    }
    
    static var anyExhibit: AnyExhibit {
        AnyExhibit(provider: self)
    }
}

public extension ExhibitProvider where Content == Layout {
    static func exhibitLayout(content: Content) -> Layout {
        content
    }
}

struct ExhibitPreview<Content: View>: View {
    let builder: (Context) -> Content
    @ObservedObject var context: Context
    
    var body: some View {
        builder(context)
    }
}
