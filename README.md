# Exhibition

Exhibition is a framework and generator for displaying a SwiftUI component library.

Inspired by [Storybook](https://storybook.js.org/) and [Showkase](https://github.com/airbnb/Showkase)

# Installation

### Swift Package Manager

# Usage

1. Add Exhibition to your project via Swift package manager using `https://github.com/mjarvis/Exhibition.git`
2. Install [Sourcery](https://github.com/krzysztofzablocki/Sourcery)
3. Copy [Exhibition.swifttemplate](./Exhibition.swifttemplate) into your project
4. Modify your SwiftUI previews to use `ExhibitProvider`
    ```swift
    import Exhibition
    
    struct Foo_Previews: ExhibitProvider, PreviewProvider {
        static var exhibit = Exhibit(name: "Foo") { parameters in
            Foo(
                title: parameters.constant(name: "title", defaultValue: "Title"),
                content: parameters.binding(name: "content")
            )
            .previewLayout(.sizeThatFits)
        }
    }
    ```
5. Run `Sourcery` to generate your Exhibition: `sourcery --sources Your/Source/Path --templates Exhibition.swifttemplate --output ./Sources/Generated`
6. Show `exhibition` in a swift view 

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

exhibition
    .parameterView(DoublingStringParameterView.self)
```

# TODO:

- [x] Debug (#1)
    - [x] Dark mode (#1)
    - [ ] RTL
    - [ ] Text sizing
    - [ ] Investigate other assistive switches

- [ ] Search (#2)
    - Search top level
    - Search nested

- [ ] Sections (#5)
    - [ ] Collapsing
    - [ ] Rows
        - [ ] Icon
        - [ ] Title

- [ ] Exhibit
    - [x] Push
    - [ ] Present
    - [ ] Layout rules (#4)
    - [x] Parameters (#3)
    
    - [ ] Code samples (copy-able snippets)
    - [ ] Code documentation (jazzy / swiftdocc)

- [ ] Layout
    - [ ] iPhone
    - [ ] iPad
    - [ ] macOS
    - [ ] watchOS
    - [ ] tvOS


Metadata?
