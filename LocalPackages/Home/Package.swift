// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        .package(name: "Networking", path: "../Networking"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Models", path: "../Models"),
//        .package(name: "Networking", path: "../Networking")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: ["Networking", "DesignSystem", "Models"]),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
    ]
)
