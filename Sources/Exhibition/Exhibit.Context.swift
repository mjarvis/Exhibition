import SwiftUI

extension Exhibit {
    public class Context: ObservableObject {
        @Published var parameters: [String: Any] = [:]
        
        public func parameter<T>(name: String, defaultValue: T) -> T {
            guard let binding = parameters[name] else {
                parameters[name] = defaultValue
                return defaultValue
            }
            
            return binding as! T
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
    }
}
