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
    
    /// Conditionally apply modifiers to a given view
    ///
    /// See `ifLet` for version that takes an optional.
    ///
    /// - Parameters:
    ///   - condition: Condition returning true/false for execution of the following blocks
    ///   - then: If condition is true, apply modifiers here.
    ///   - else: If condition is false, apply modifiers here.
    /// - Returns: Self with modifiers applied accordingly.
    @ViewBuilder public func `if`<Then: View, Else: View>(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder then: (Self) -> Then,
        @ViewBuilder else: (Self) -> Else
    ) -> some View {
        if condition() {
            then(self)
        } else {
            `else`(self)
        }
    }

    /// Conditionally apply modifiers to a given view
    ///
    /// See `ifLet` for version that takes an optional.
    ///
    /// - Parameters:
    ///   - condition: Condition returning true/false for execution of the following blocks
    ///   - then: If condition is true, apply modifiers here.
    /// - Returns: Self with modifiers applied, or unchanged self if condition was false
    @ViewBuilder public func `if`<Then: View>(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder then: (Self) -> Then
    ) -> some View {
        if condition() {
            then(self)
        } else {
            self
        }
    }
}
