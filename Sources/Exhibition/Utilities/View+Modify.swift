import SwiftUI

/// Helpers for conditionally applying modifiers
extension View {
    
    /// Modify the current view with some given block. Useful for applying compiler conditional modifiers.
    ///
    /// Example:
    ///
    ///     Rectangle().modify {
    ///         #if os(iOS)
    ///             $0.fill(Color.red)
    ///         #else
    ///            $0.fill(Color.blue)
    ///         #endif
    ///     }
    ///
    /// - Returns: A modified view
    func modify<Output: View>(
        @ViewBuilder _ block: (Self) -> Output
    ) -> some View {
        block(self)
    }
}
