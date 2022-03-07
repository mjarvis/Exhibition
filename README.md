# Exhibition

![CI](https://github.com/mjarvis/exhibition/actions/workflows/test.yml/badge.svg)

Exhibition is a framework and generator for displaying and debugging a SwiftUI component library.

Inspired by [Storybook](https://storybook.js.org/) and [Showkase](https://github.com/airbnb/Showkase)

# Installation

### Swift Package Manager

1. Add `https://github.com/mjarvis/Exhibition` to your project via Xcode.
2. Install [Sourcery](https://github.com/krzysztofzablocki/Sourcery)
3. Copy [Exhibition.swifttemplate](./Exhibition.swifttemplate) into your project

# Usage

1. Modify your SwiftUI previews to use `ExhibitProvider`
    ```swift
    import Exhibition
    
    struct Foo_Previews: ExhibitProvider, PreviewProvider {
        static var exhibit = Exhibit(
            name: "Foo",
            section: "Bar"
        ) { context in
            Foo(
                title: context.parameter(name: "title", defaultValue: "Title"),
                content: context.parameter(name: "content")
            )
        }
    }
    ```
5. Run `Sourcery` to generate your Exhibition: `sourcery --sources Your/Source/Path --templates Exhibition.swifttemplate --output ./Sources/Generated`
6. Show `Exhibition()` in a swift view

# Custom Layout

If you would like your exhibit to have some custom layout, there is an optional function in `ExhibitProvider` you can implement.

Here is an example of embeding the exhibit within a `List`:

```swift
    static func exhibitLayout(_ content: Foo) -> some View {
        List {
            content
        }
    }
```

You can also provide a custom `View` here to provide presentation samples:

```swift
    struct CustomLayout: View {
        let content: Foo
        
        @State var isPresented: Bool = false
        
        var body: some View {
            Button("Open") {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                content
            }
        }
    }

    static func exhibitLayout(_ content: Foo) -> some View {
        CustomLayout(content: content)
    }
```

# Custom Parameter views

Exhibition supports a number of types in the parameter list of the debug menu. 
You can add your own arbitrary types along with a view to modify the parameter, or override the views for existing types.
Conform to `ParameterView`, and pass the type in via the `.parameterView` modifier on `Exhibition`.

```swift
struct DoublingStringParameterView: ParameterView {
    let key: String
    @Binding var value: String
    
    var body: some View {
        Button(key) {
            value += value
        }
    }
}

Exhibition()
    .parameterView(DoublingStringParameterView.self)
```
