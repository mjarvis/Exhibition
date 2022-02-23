import Foundation
import SwiftUI

/// A parameter representing a closure / function typed parameter.
/// EG: `action: () -> Void`
public struct ClosureParameter {
    /// The signature of the closure, eg `"() -> Void"`
    public let signature: String
    
    /// The number of times this closure has been called
    public var callCount: Int = 0
    
    /// Initialize a `ClosureParameter`
    /// - Parameter signature: The signature of the closure, such as `"() -> Void"`
    public init(signature: String) {
        self.signature = signature
    }
}

struct ClosureParameterView: ParameterView {
    let key: String
    @Binding var value: ClosureParameter
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value.signature)
            Spacer()
            Text(value.callCount.formatted())
        }
    }
}
