import SwiftUI

/// Wrapper for an `ExhibitProvider` erasing the Content and Layout types.
public struct AnyExhibit {
    let name: String
    let section: String
    let content: (Context) -> AnyView
    let context = Context()
    
    init<P: ExhibitProvider>(provider: P.Type) {
        self.name = provider.exhibitName
        self.section = provider.exhibitSection
        self.content = { context in
            AnyView(provider.exhibitLayout(content: AnyView(provider.exhibitContent(context: context))))
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
    
    init(exhibit: AnyExhibit) {
        self.exhibit = exhibit
        self.context = exhibit.context
    }
    
    var body: some View {
        exhibit.content(context)
    }
}
