// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GBHomeWork2",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/peripheryapp/periphery", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GBHomeWork2",
            dependencies: []),
        .testTarget(
            name: "GBHomeWork2Tests",
            dependencies: ["GBHomeWork2"])
    ]
)
