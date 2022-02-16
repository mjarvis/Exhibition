import SwiftUI

/// A presented view used to modify accessibility and exhibit parameters.
struct DebugView: View {
    @ObservedObject var parameters: Exhibit.Parameters
    
    @Binding var preferredColorScheme: ColorScheme
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.parameterViews) var parameterViews
    
    init(
        parameters: Exhibit.Parameters,
        preferredColorScheme: Binding<ColorScheme>
    ) {
        self.parameters = parameters
        _preferredColorScheme = preferredColorScheme
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Accessibility") {
                    Picker("Color Scheme", selection: $preferredColorScheme) {
                        Text("Light").tag(ColorScheme.light)
                        Text("Dark").tag(ColorScheme.dark)
                    }
                }
                
                Section("Parameters") {
                    ForEach(
                        parameters.values.sorted(by: parameterSort), id: \.key,
                        content: parameterView
                    )
                }
            }
            .navigationTitle("Debug")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(preferredColorScheme)
    }
    
    private func parameterSort(left: (key: String, value: Any), right: (key: String, value: Any)) -> Bool {
        return left.key < right.key
    }
    
    private func parameterView(parameter: (key: String, value: Any)) -> AnyView? {
        let view = parameterViews
            .lazy
            .compactMap { parameterView in
                parameterView(parameter.key, parameter.value, parameters)
            }
            .first
        
        return view ?? AnyView(Text(parameter.key))
    }
}
