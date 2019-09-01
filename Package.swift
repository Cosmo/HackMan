// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HackMan",
    products: [
        .executable(name: "hackman", targets: ["HackMan"]),
        .library(name: "HackManLib", targets: ["HackManLib"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/stencilproject/Stencil.git", .branch("master")),
        .package(url: "https://github.com/Cosmo/GrammaticalNumber.git", from: "0.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "HackManLib",
            dependencies: ["Stencil", "GrammaticalNumber"]),
        .target(
            name: "HackMan",
            dependencies: ["HackManLib"]),
        .testTarget(
            name: "HackManTests",
            dependencies: ["HackManLib"]),
    ]
)
