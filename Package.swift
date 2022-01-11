// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Exhibit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "Exhibit",
            targets: ["Exhibit"]
        ),
    ],
    targets: [
        .target(
            name: "Exhibit"
        ),
        .testTarget(
            name: "ExhibitTests",
            dependencies: ["Exhibit"]
        ),
    ]
)
