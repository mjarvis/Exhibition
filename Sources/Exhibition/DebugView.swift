import SwiftUI

/// A presented view used to modify accessibility and exhibit parameters.
struct DebugView: View {
    @ObservedObject var context: Exhibit.Context
    
    @Binding var preferredColorScheme: ColorScheme
    @Binding var layoutDirection: LayoutDirection
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.parameterViews) var parameterViews
    
    var body: some View {
        NavigationView {
            Form {
                Section("Accessibility") {
                    Picker("Color Scheme", selection: $preferredColorScheme) {
                        Text("Light").tag(ColorScheme.light)
                        Text("Dark").tag(ColorScheme.dark)
                    }
                    
                    Picker("Layout Direction", selection: $layoutDirection) {
                        Text("Left to Right").tag(LayoutDirection.leftToRight)
                        Text("Right to Left").tag(LayoutDirection.rightToLeft)
                    }
                }
                
                if context.parameters.isEmpty == false {
                    Section("Parameters") {
                        ForEach(
                            context.parameters.sorted(by: parameterSort), id: \.key,
                            content: parameterView
                        )
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
    
    private func parameterSort(left: (key: String, value: Any), right: (key: String, value: Any)) -> Bool {
        return left.key < right.key
    }
    
    private func parameterView(parameter: (key: String, value: Any)) -> AnyView? {
        let view = parameterViews
            .lazy
            .compactMap { parameterView in
                parameterView(parameter.key, parameter.value, context)
            }
            .first
        
        return view ?? AnyView(Text(parameter.key))
    }
}
