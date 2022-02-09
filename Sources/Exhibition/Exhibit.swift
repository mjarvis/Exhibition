import SwiftUI

public struct Exhibit: View {
 
    let name: String
    let view: (Parameters) -> AnyView
    
    @ObservedObject var parameters = Parameters()
        
    public init<T: View>(name: String, @ViewBuilder _ builder: @escaping (Parameters) -> T) {
        self.name = name
        view = { parameters in AnyView(builder(parameters)) }
    }
    
    public var body: some View {
        view(parameters)
    }
}

extension Exhibit: Identifiable {
    public var id: String {
        name
    }
}

extension Exhibit {
    public class Parameters: ObservableObject {
        @Published private var values: [String: Any] = [:]
        
        public func constant<T>(name: String, defaultValue: T) -> T {
            guard let binding = values[name] else {
                values[name] = defaultValue
                return defaultValue
            }
            
            return binding as! T
        }
        
        public func binding<T>(name: String, defaultValue: T) -> Binding<T> {
            return Binding(
                get: { [unowned self] in
                    self.constant(name: name, defaultValue: defaultValue)
                },
                set: { [unowned self] newValue in
                    values[name] = newValue
                }
            )
        }
    }
}

