# Exhibition

Exhibition is a framework and generator for displaying a SwiftUI component library.

Inspired by [Storybook](https://storybook.js.org/) and [Showkase](https://github.com/airbnb/Showkase)

# Installation

### Swift Package Manager

# Usage

1. Install [Sourcery](https://github.com/krzysztofzablocki/Sourcery)
2. Copy [Exhibition.swifttemplate](./Exhibition.swifttemplate) into your project
3. Modify your SwiftUI previews to use `ExhibitProvider`
    ```swift
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
4. Run `Sourcery` to generate your Exhibition: `sourcery --sources Your/Source/Path --templates Exhibition.swifttemplate --output ./Sources/Generated`
5. Show `exhibition` in a swift view 

# TODO:

- [ ] Debug
    - [ ] Dark mode
    - [ ] RTL
    - [ ] Text sizing
    - [ ] Investigate other assistive switches

- [ ] Search
    - Search top level
    - Search nested

- [ ] Sections
    - [ ] Collapsing
    - [ ] Rows
        - [ ] Icon
        - [ ] Title

- [ ] Element
    - [ ] Push
    - [ ] Present
    - [ ] Layout rules
    - [ ] Parameters
    
    - [ ] Code samples (copy-able snippets)
    - [ ] Code documentation (jazzy / swiftdocc)

- [ ] Layout
    - [ ] iPhone
    - [ ] iPad
    - [ ] macOS
    - [ ] watchOS
    - [ ] tvOS
