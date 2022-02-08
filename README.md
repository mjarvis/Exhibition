# Exhibition

A description of this package.


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
    - [ ] Variants
    
    - [ ] Code samples (copy-able snippets)
    - [ ] Code documentation (jazzy / swiftdocc)


# Possiblities

### Generative

Auto-generator that creates the above based on some protocol on previews.
Pulls documentation from swiftdocc.
Generates swift code for the exhibit.

### Parameter modification

Debug menu which allows modification of values passed into components


# How?

Problem: Views contained in swift package
Exported file must be imported into package?


Two parts:
1. Script that runs and generates the exhibition
2. Framework to import for the protocols + helpers.



Use Sourcery for the script.

Parameter modification via `binding() -> T` function in `Exhibit`

```swift
protocol ExhibitProvider {
    static var exhibit: Exhibit
}

struct Exhibit: View {
    
    public init<T: View>(@ViewBuilder _ builder: (Bindings) -> T) {
        
    }
}
```
