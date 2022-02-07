import Foundation
import SwiftUI

public struct Item {
    let variant: String
    let view: AnyView
    
    public init<T: View>(
        variant: String,
        layout: PreviewLayout = .sizeThatFits,
        view: T
    ) {
        self.variant = variant
        self.view = AnyView(
            view
                .previewDisplayName(variant)
        )
    }
}

extension Item: Identifiable {
    public var id: String {
        variant
    }
}
