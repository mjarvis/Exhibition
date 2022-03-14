import SwiftUI

public class Context: ObservableObject {
    @Published var parameters: [String: Any]
    @Published var log: [String] = []
    
    init(parameters: [String: Any] = [:]) {
        self.parameters = parameters
    }
    
    /// Reset parameters to default values
    public func resetParameters() {
        parameters.removeAll()
    }
    
    /// Clear the log
    public func clearLog() {
        log.removeAll()
    }
    
    public func parameter<T>(name: String, defaultValue: T) -> T {
        guard let binding = parameters[name] else {
            parameters[name] = defaultValue
            return defaultValue
        }
        
        return binding as? T ?? defaultValue
    }
    
    public func parameter<T>(name: String) -> T where T: Defaultable {
        parameter(name: name, defaultValue: T.defaultValue)
    }
    
    public func parameter<T>(name: String, defaultValue: T) -> Binding<T> {
        return Binding(
            get: { [unowned self] in
                self.parameter(name: name, defaultValue: defaultValue)
            },
            set: { [unowned self] newValue in
                parameters[name] = newValue
            }
        )
    }
    
    public func parameter<T>(name: String) -> Binding<T> where T: Defaultable {
        parameter(name: name, defaultValue: T.defaultValue)
    }
    
    public func log(_ text: String) {
        log.append(text)
    }
}

// MARK: - Closure Parameters

extension Context {
    /// A closure parameter with no arguments
    ///
    /// EG: `action: () -> Void`
    ///
    /// - Parameter name: The name of the parameter
    /// - Returns: A closure to be executed by the view.
    public func parameter(name: String) -> () -> Void {
        let parameter = closureParameter(
            name: name,
            signature: "() -> Void"
        )

        return { [unowned self] in
            parameter.wrappedValue.callCount += 1
            self.log("\(name): ())")
        }
    }
    
    /// A closure parameter with a single argument
    ///
    /// EG: `action: (String) -> Void`
    ///
    /// - Parameter name: The name of the parameter
    /// - Returns: A closure to be executed by the view
    public func parameter<A>(name: String) -> (A) -> Void {
        let parameter = closureParameter(
            name: name,
            signature: "(\(A.self)) -> Void"
        )
        
        return { [unowned self] a in
            parameter.wrappedValue.callCount += 1
            self.log("\(name): (\(a))")
        }
    }
    
    /// A closure parameter with two arguments
    ///
    /// EG: `action: (String, Int) -> Void`
    ///
    /// - Parameter name: The name of the parameter
    /// - Returns: A closure to be executed by the view
    public func parameter<A, B>(name: String) -> (A, B) -> Void {
        let parameter = closureParameter(
            name: name,
            signature: "(\(A.self), \(B.self)) -> Void"
        )
        
        return { [unowned self] a, b in
            parameter.wrappedValue.callCount += 1
            self.log("\(name): (\(a), \(b))")
        }
    }
    
    /// A closure parameter with three arguments
    ///
    /// EG: `action: (String, Int, Bool) -> Void`
    ///
    /// - Parameter name: The name of the parameter
    /// - Returns: A closure to be executed by the view
    public func parameter<A, B, C>(name: String) -> (A, B, C) -> Void {
        let parameter = closureParameter(
            name: name,
            signature: "(\(A.self), \(B.self), \(C.self)) -> Void"
        )
        
        return { [unowned self] a, b, c in
            parameter.wrappedValue.callCount += 1
            self.log("\(name): (\(a), \(b), \(c))")
        }
    }
    
    /// A closure parameter with four arguments
    ///
    /// EG: `action: (String, Int, Bool, String) -> Void`
    ///
    /// - Parameter name: The name of the parameter
    /// - Returns: A closure to be executed by the view
    public func parameter<A, B, C, D>(name: String) -> (A, B, C, D) -> Void {
        let parameter = closureParameter(
            name: name,
            signature: "(\(A.self), \(B.self), \(C.self), \(D.self)) -> Void"
        )
        
        return { [unowned self] a, b, c, d in
            parameter.wrappedValue.callCount += 1
            self.log("\(name): (\(a), \(b), \(c), \(d))")
        }
    }
    
    /// Helper for creating a `ClosureParameter` binding without specifying types.
    private func closureParameter(
        name: String,
        signature: String
    ) -> Binding<ClosureParameter> {
        parameter(
            name: name,
            defaultValue: .init(signature: signature)
        )
    }
}
