// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "FastAppLibrary",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "FastAppLibrary",
            targets: ["FastAppLibrary"]),
    ],
    dependencies: [
        .package(url: "https://github.com/RevenueCat/purchases-ios-spm.git", from: Version("5.0.0")),
        .package(url: "https://github.com/elai950/AlertToast.git", branch: "master"),
        .package(url: "https://github.com/gonzalezreal/swift-markdown-ui", from: "2.0.2"),
        .package(url: "https://github.com/jessesquires/Foil.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "FastAppLibrary",
            dependencies: [
                .product(name: "RevenueCat", package: "purchases-ios-spm"),
                .product(name: "AlertToast", package: "AlertToast"),
                .product(name: "MarkdownUI", package: "swift-markdown-ui"),
                .product(name: "Foil", package: "Foil")
            ],
            path: "Sources",
            resources: [
                .process("Assets.xcassets"),
                .process("Resources")
            ]),
        
            .testTarget(
                name: "FastAppLibraryTests",
                dependencies: ["FastAppLibrary"]),
    ]
)
