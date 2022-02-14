import SwiftUI

/// A presented view used to modify accessibility and exhibit parameters.
struct DebugView: View {
    @ObservedObject var parameters: Exhibit.Parameters
    
    @Binding var preferredColorScheme: ColorScheme
    
    @Environment(\.dismiss) var dismiss
    
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
                    ForEach(Array(parameters.values.keys), id: \.self) { key in
                        Text("\(key)")
                    }
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
}
