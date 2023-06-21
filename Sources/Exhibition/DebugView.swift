import SwiftUI

/// A presented view used to modify accessibility and exhibit parameters.
struct DebugView: View {
    @ObservedObject var context: Context
    
    @Binding var preferredColorScheme: ColorScheme
    @Binding var layoutDirection: LayoutDirection
    @Binding var contentSizeCategory: ContentSizeCategory
    
    let resetAllContexts: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
//    @Environment(\.parameterViews) var parameterViews
    
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
                    
                    Picker("Content Size Category", selection: $contentSizeCategory) {
                        ForEach(ContentSizeCategory.allCases, id: \.self) { size in
                            Text(String(describing: size)).tag(size)
                        }
                    }
                    
                    Button("Reset") {
                        preferredColorScheme = .light
                        layoutDirection = .leftToRight
                    }
                    .foregroundColor(.red)
                } header: {
                    Text("Accessibility")
                }
                
                if context.parameters.isEmpty {
                    Section {
                        Button("Reset all Exhibits") {
                            resetAllContexts()
                        }
                        .foregroundColor(.red)
                    }
                } else {
                    Section {
                        ForEach(
                            context.parameters.sorted(by: keyAscending), id: \.key) { (key: String, value: AnyParameter) in
                                
                            }
                        
                        Button("Reset") {
                            DispatchQueue.main.async {
                                // Without the dispatch, this causes the parameter list to blink
                                context.resetParameters()
                            }
                        }
                        .foregroundColor(.red)
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
                        
                        Button("Clear") {
                            context.clearLog()
                        }
                        .foregroundColor(.red)
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
    
//    @ViewBuilder private func parameterView(parameter: (key: String, value: Any)) -> some View {
//        if let view = possibleParameterView(parameter: parameter) {
//            view
//        } else {
//            UnknownParameterView(
//                key: parameter.key,
//                value: context.parameter(name: parameter.key, defaultValue: parameter.value)
//            )
//        }
//    }
//
//    private func possibleParameterView(parameter: (key: String, value: Any)) -> AnyView? {
//        parameterViews
//            .lazy
//            .compactMap { parameterView in
//                parameterView(parameter.key, parameter.value, context)
//            }
//            .first
//    }
}
