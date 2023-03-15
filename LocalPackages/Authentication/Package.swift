// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
    ],
    dependencies: [
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Networking", path: "../Networking"),
        .package(name: "Models", path: "../Models"),
    ],
    targets: [
        .target(
            name: "Authentication",
            dependencies: [
                "DesignSystem",
                "Networking",
                "Models"
            ]),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: ["Authentication"]),
    ]
)
