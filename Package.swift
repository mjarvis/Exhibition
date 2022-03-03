// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Exhibition",
    platforms: [
        .iOS(.v15),
        .macOS(.v11),
        .watchOS(.v8),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "Exhibition",
            targets: ["Exhibition"]
        )
    ],
    targets: [
        .target(
            name: "Exhibition"
        ),
        .testTarget(
            name: "ExhibitionTests",
            dependencies: ["Exhibition"]
        )
    ]
)
