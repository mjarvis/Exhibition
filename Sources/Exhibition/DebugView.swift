import SwiftUI

/// A presented view used to modify accessibility and exhibit parameters.
struct DebugView: View {
    @ObservedObject var context: Context
    
    @Binding var preferredColorScheme: ColorScheme
    @Binding var layoutDirection: LayoutDirection
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.parameterViews) var parameterViews
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Color Scheme", selection: $preferredColorScheme) {
                        Text("Light").tag(ColorScheme.light)
                        Text("Dark").tag(ColorScheme.dark)
                    }
                    
                    Picker("Layout Direction", selection: $layoutDirection) {
                        Text("Left to Right").tag(LayoutDirection.leftToRight)
                        Text("Right to Left").tag(LayoutDirection.rightToLeft)
                    }
                } header: {
                    Text("Accessibility")
                }
                
                if context.parameters.isEmpty == false {
                    Section {
                        ForEach(
                            context.parameters.sorted(by: keyAscending), id: \.key,
                            content: parameterView
                        )
                    } header: {
                        Text("Parameters")
                    }
                }
                
                if context.log.isEmpty == false {
                    Section {
                        Text(context.log.joined(separator: "\n"))
                            .modify {
                                #if os(iOS)
                                    $0.textSelection(.enabled)
                                #else
                                    $0
                                #endif
                            }
                    } header: {
                        Text("Log")
                    }
                }
            }
            .navigationTitle("Debug")
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(preferredColorScheme)
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
