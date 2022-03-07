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
            .previewLayout(.sizeThatFits)
        }
    }
    ```
5. Run `Sourcery` to generate your Exhibition: `sourcery --sources Your/Source/Path --templates Exhibition.swifttemplate --output ./Sources/Generated`
6. Show `Exhibition()` in a swift view 

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
