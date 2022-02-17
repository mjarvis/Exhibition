import SwiftUI

public struct Exhibit: View {
 
    let name: String
    let section: String
    let view: (Parameters) -> AnyView
    
    @ObservedObject var parameters = Parameters()
    
    public init<T: View>(name: String, section: String = "", @ViewBuilder _ builder: @escaping (Parameters) -> T) {
        self.name = name
        self.section = section
        view = { parameters in AnyView(builder(parameters)) }
    }
    
    public var body: some View {
        view(parameters)
            .navigationTitle(name)
    }
}

extension Exhibit: Identifiable {
    public var id: String {
        name
    }
}

extension Exhibit {
    public class Parameters: ObservableObject {
        @Published var values: [String: Any] = [:]
        
        public func constant<T>(name: String, defaultValue: T) -> T {
            guard let binding = values[name] else {
                values[name] = defaultValue
                return defaultValue
            }
            
            return binding as! T
        }
        
        public func constant<T>(name: String) -> T where T: Defaultable {
            constant(name: name, defaultValue: T.defaultValue)
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
        
        public func binding<T>(name: String) -> Binding<T> where T: Defaultable {
            binding(name: name, defaultValue: T.defaultValue)
        }
    }
}
