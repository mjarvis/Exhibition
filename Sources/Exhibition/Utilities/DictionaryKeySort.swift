import Foundation

func keyAscending<Value>(left: (key: String, value: Value), right: (key: String, value: Value)) -> Bool {
    return left.key < right.key
}
