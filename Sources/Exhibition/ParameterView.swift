import SwiftUI

// MARK: - Public

/// A view used for manipulating an Exhibit parameter via the Debug view.
/// See `StringParameterView` for an example implementation.
public protocol ParameterView: View {
    associatedtype Value
    init(key: String, value: Binding<Value>)
}

extension View {
    /// Adds or overrides a debug parameter view.
    /// Intended to be applied to an `Exhibition`
    ///
    /// eg: `exhibition.parameterView(CustomParameterView.self)`
    ///
    /// - Returns: The existing view.
    @ViewBuilder public func parameterView<P: ParameterView>(_ parameterView: P.Type) -> some View {
        self
            .modifier(ParameterViewModifier(parameterView: erase(parameterView)))
    }
}

// MARK: - Internal

/// Type erased parameter view for storage in an array.
typealias AnyParameterView = (String, Any, Exhibit.Context) -> AnyView?
func erase<P: ParameterView>(_ parameterView: P.Type) -> AnyParameterView {
    return { name, value, parameters in
        guard let value = value as? P.Value else {
            return nil
        }
        
        return AnyView(
            parameterView.init(
                key: name,
                value: parameters.parameter(name: name, defaultValue: value)
            )
        )
    }
}

struct ParameterViewsEnvironmentKey: EnvironmentKey {
    static var defaultValue: [AnyParameterView] = []
}

extension EnvironmentValues {
    var parameterViews: [AnyParameterView] {
        get { self[ParameterViewsEnvironmentKey.self] }
        set { self[ParameterViewsEnvironmentKey.self] = newValue }
    }
}

// MARK: - Private

private struct ParameterViewModifier: ViewModifier {
    @Environment(\.parameterViews) var parameterViews
    
    let parameterView: AnyParameterView
    
    func body(content: Content) -> some View {
        content
            .environment(\.parameterViews, parameterViews + [parameterView])
    }
}
