// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// let package = Package(
//     name: "happ",
//     products: [
//         .library(
//             name: "HappCore",
//             targets: ["HappCore"]
//         ),
//         .executable(name: "hello-world-swift", targets: ["HelloWorld"]),
//     ],
//     dependencies: [
//         // Dependencies declare other packages that this package depends on.
//         // .package(url: /* package url */, from: "1.0.0"),
//     ],
//     targets: [
//         // Targets are the basic building blocks of a package. A target can define a module or a test suite.
//         // Targets can depend on other targets in this package, and on products in packages this package depends on.
//         .target(
//             name: "HappCore",
//             dependencies: [],
//             path: "Sources/Core"),
//         .target(
//             name: "HelloWorld",
//             dependencies: [
//                 .target(name: "HappCore"),
//             ]),
//     ]
// )

// let package = Package(
//     name: "Happ",
//     products: [
//         .executable(name: "hello-world", targets: ["hello-world"]),
//         .library(name: "HappCore", targets: ["happ-core"]),
//         .library(name: "HappCoreStatic", type: .static, targets: ["happ-core"]),
//         .library(name: "HappCoreDynamic", type: .dynamic, targets: ["happ-core"]),
//     ],
//     dependencies: [
//         // .package(url: "http://example.com.com/ExamplePackage/ExamplePackage", from: "1.2.3"),
//         // .package(url: "http://some/other/lib", .exact("1.2.3")),
//     ],
//     targets: [
//         .target(
//             name: "hello-world",
//             dependencies: [
//                 .product(name: "happ-core"),
//             ],
//             path: "Sources/HelloWorld"),
//         .target(
//             name: "happ-core",
//             dependencies: [
//                 // "Basic",
//                 // .target(name: "Utility"),
//                 // .product(name: "AnotherExamplePackage"),
//             ],
//             path: "Sources/Core")
//     ]
// )

let package = Package(
    name: "Happ",
    platforms: [
        .macOS(.v10_14),
    ],
    products: [
        .library(name: "happ-core", targets: ["HappCore"]),
        .library(name: "happ-core-static", type: .static, targets: ["HappCore"]),
        .library(name: "happ-core-dynamic", type: .dynamic, targets: ["HappCore"]),
        .executable(name: "hello-world-swift", targets: ["HelloWorld"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HappCore",
            dependencies: [
            ],
            path: "Sources/Core"),
        .target(
            name: "HelloWorld",
            dependencies: [
                .target(name: "HappCore"),
            ],
            path: "Sources/HelloWorld")
    ]
)