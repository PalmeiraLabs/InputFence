// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InputFence",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "InputFence",
            targets: ["InputFence"]),
    ],
    dependencies: [
        .package(url: "https://github.com/marmelroy/PhoneNumberKit.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "InputFence",
            dependencies: [
            .product(name: "PhoneNumberKit", package: "PhoneNumberKit")
        ]),
        .testTarget(
            name: "InputFenceTests",
            dependencies: ["InputFence"]
        ),
    ]
)
