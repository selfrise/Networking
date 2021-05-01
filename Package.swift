// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "Networking", targets: ["Networking"])
    ],
    targets: [
        .target(
            name: "Networking",
            path: "Networking"
        )
    ]
)