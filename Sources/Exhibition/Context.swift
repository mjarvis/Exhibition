import SwiftUI

public protocol AnyParameter {}

struct Parameter<T, V: View>: AnyParameter {
    let value: T
    let view: (String, Binding<T>) -> V
}

//protocol ParameterView: View {
//    var value
//}

public class Context: ObservableObject {
    var parameters: [String: AnyParameter]
    @Published var log: [String] = []
    
    init(parameters: [String: AnyParameter] = [:]) {
        self.parameters = parameters
    }
    
    /// Reset parameters to default values
    public func resetParameters() {
        objectWillChange.send()
        parameters.removeAll()
    }
    
    /// Clear the log
    public func clearLog() {
        log.removeAll()
    }
    
    public func parameter<T, V: View>(name: String, defaultValue: T, view: @escaping (String, Binding<T>) -> V) -> T {
        guard let parameter = parameters[name] as? Parameter<T, V> else {
            parameters[name] = Parameter(value: defaultValue, view: view)
            return defaultValue
        }
        
        return parameter.value
    }
    
    public func parameter<T, V: View>(name: String, view: @escaping (String, Binding<T>) -> V) -> T where T: Defaultable {
        parameter(name: name, defaultValue: T.defaultValue, view: view)
    }
    
    public func parameter<T, V: View>(name: String, defaultValue: T, view: @escaping (String, Binding<T>) -> V) -> Binding<T> {
        return Binding(
            get: { [unowned self] in
                self.parameter(name: name, defaultValue: defaultValue, view: view)
            },
            set: { [unowned self] newValue in
                objectWillChange.send()
                parameters[name] = Parameter(value: newValue, view: view)
            }
        )
    }
    
    public func parameter<T, V: View>(name: String, view: @escaping (String, Binding<T>) -> V) -> Binding<T> where T: Defaultable {
        parameter(name: name, defaultValue: T.defaultValue, view: view)
    }
    
    public func log(_ text: String) {
        log.append(text)
    }
}
