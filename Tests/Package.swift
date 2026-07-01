// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "testing",
    platforms: [
        .macOS(.v26),
    ],
    dependencies: [
        .package(path: ".."),
        .package(url: "https://github.com/swift-foundations/swift-testing.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-html-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-test-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "HTML Snapshot Test Support",
            dependencies: [
                .product(name: "HTML Rendering Core Test Support", package: "swift-html-render"),
                .product(name: "Testing", package: "swift-testing"),
                .product(name: "HTML Standard Test Support", package: "swift-html-standard"),
                .product(name: "Test Snapshot Primitives", package: "swift-test-primitives"),
            ],
            path: "Snapshot Support"
        ),
        .testTarget(
            name: "HTML Rendering Core Snapshot Tests",
            dependencies: [
                "HTML Snapshot Test Support",
                .product(name: "Testing", package: "swift-testing"),
            ],
            path: "HTML Renderable Snapshot Tests"
        ),
        .testTarget(
            name: "HTML Rendering Core Performance Tests",
            dependencies: [
                "HTML Snapshot Test Support",
                .product(name: "Testing", package: "swift-testing"),
            ],
            path: "HTML Renderable Performance Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
