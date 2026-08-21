// swift-tools-version: 6.4

import PackageDescription

extension String {
    static let htmlRenderingCore: Self = "HTML Rendering Core"
    static let htmlAttributesRendering: Self = "HTML Attributes Rendering"
    static let htmlElementsRendering: Self = "HTML Elements Rendering"
    static let htmlRendering: Self = "HTML Rendering"
//    static let htmlSnapshotTestSupport: Self = "HTML Snapshot Test Support"
    var tests: Self { self + " Tests" }
}

extension Target.Dependency {
    static var htmlRenderingCore: Self { .target(name: .htmlRenderingCore) }
    static var htmlAttributesRendering: Self { .target(name: .htmlAttributesRendering) }
    static var htmlElementsRendering: Self { .target(name: .htmlElementsRendering) }
    static var htmlRenderingCoreTestSupport: Self {
        .target(name: "HTML Rendering Core Test Support")
    }
}

extension Target.Dependency {
    static var renderingPrimitives: Self {
        .product(name: "Render Primitives", package: "swift-render-primitives")
    }
    static var ascii: Self {
        .product(name: "ASCII", package: "swift-ascii")
    }
    static var htmlStandard: Self {
        .product(name: "HTML Standard", package: "swift-html-standard")
    }
    static var htmlStandardAttributes: Self {
        .product(name: "HTML Standard Attributes", package: "swift-html-standard")
    }
    static var htmlStandardElements: Self {
        .product(name: "HTML Standard Elements", package: "swift-html-standard")
    }
    static var htmlStandardTestSupport: Self {
        .product(name: "HTML Standard Test Support", package: "swift-html-standard")
    }
    static var whatwgHTMLShared: Self {
        .product(name: "WHATWG HTML Shared", package: "swift-whatwg-html")
    }
//    static var testSnapshotPrimitives: Self {
//        .product(name: "Test Snapshot Primitives", package: "swift-test-primitives")
//    }
    static var w3cCSSShared: Self {
        .product(name: "W3C CSS Shared", package: "swift-w3c-css")
    }
    static var dictionaryPrimitives: Self {
        .product(name: "Dictionary Primitives", package: "swift-dictionary-primitives")
    }
    static var sharedPrimitive: Self {
        .product(name: "Ownership Shared Primitive", package: "swift-ownership-shared-primitives")
    }
    static var hashIndexedPrimitive: Self {
        .product(name: "Hash Indexed Primitive", package: "swift-hash-table-primitives")
    }
    static var columnPrimitives: Self {
        .product(name: "Column Primitives", package: "swift-column-primitives")
    }
    static var hashPrimitives: Self {
        .product(name: "Hash Primitives", package: "swift-hash-primitives")
    }
    static var bufferLinearPrimitive: Self {
        .product(name: "Buffer Linear Primitive", package: "swift-buffer-linear-primitives")
    }
    static var ownershipMutablePrimitives: Self {
        .product(name: "Ownership Mutable Primitives", package: "swift-ownership-primitives")
    }
    static var asyncChannelPrimitives: Self {
        .product(name: "Async Channel Primitives", package: "swift-async-primitives")
    }
    static var asyncPrimitive: Self {
        .product(name: "Async Primitive", package: "swift-async-primitives")
    }
}

let package = Package(
    name: "swift-html-render",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: .htmlRenderingCore, targets: [.htmlRenderingCore]),
        .library(name: .htmlAttributesRendering, targets: [.htmlAttributesRendering]),
        .library(name: .htmlElementsRendering, targets: [.htmlElementsRendering]),
        .library(name: .htmlRendering, targets: [.htmlRendering]),
        .library(
            name: "HTML Rendering Core Test Support",
            targets: ["HTML Rendering Core Test Support"]
        ),
//        .library(name: .htmlSnapshotTestSupport, targets: [.htmlSnapshotTestSupport]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-render-primitives.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-foundations/swift-ascii.git", branch: "main"),
        .package(url: "https://github.com/swift-standards/swift-html-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-whatwg/swift-whatwg-html.git", branch: "main"),
        .package(url: "https://github.com/swift-w3c/swift-w3c-css.git", branch: "main"),
//        .package(
//            url: "https://github.com/swift-primitives/swift-test-primitives.git",
//            branch: "main"
//        ),
        .package(
            url: "https://github.com/swift-primitives/swift-dictionary-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-dictionary-ordered-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ownership-shared-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-table-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-column-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-buffer-linear-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ownership-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-async-primitives.git",
            branch: "main"
        ),
    ],
    targets: [

        // MARK: - Core

        .target(
            name: .htmlRenderingCore,
            dependencies: [
                .renderingPrimitives,
                .ascii,
                .w3cCSSShared,
                .htmlStandard,
                .dictionaryPrimitives,
                .product(
                    name: "Dictionary Ordered Primitives",
                    package: "swift-dictionary-ordered-primitives"
                ),
                .sharedPrimitive,
                .hashIndexedPrimitive,
                .columnPrimitives,
                .hashPrimitives,
                .bufferLinearPrimitive,
                .ownershipMutablePrimitives,
                .asyncChannelPrimitives,
                .asyncPrimitive,
            ]
        ),

        // MARK: - Attributes

        .target(
            name: .htmlAttributesRendering,
            dependencies: [
                .htmlStandard,
                .htmlRenderingCore,
                .htmlStandardAttributes,
            ]
        ),

        // MARK: - Elements

        .target(
            name: .htmlElementsRendering,
            dependencies: [
                .htmlStandard,
                .htmlAttributesRendering,
                .htmlStandardElements,
            ]
        ),

        // MARK: - Umbrella

        .target(
            name: .htmlRendering,
            dependencies: [
                .htmlStandard,
                .htmlAttributesRendering,
                .htmlElementsRendering,
            ]
        ),

        // MARK: - Test Support

        .target(
            name: "HTML Rendering Core Test Support",
            dependencies: [
                .htmlRenderingCore,
                .w3cCSSShared,
            ],
            path: "Tests/Support"
        ),

//        .target(
//            name: .htmlSnapshotTestSupport,
//            dependencies: [
//                .htmlRenderingCore,
//                .htmlRenderingCoreTestSupport,
//                .htmlStandardTestSupport,
//                .testSnapshotPrimitives,
//                .whatwgHTMLShared,
//            ],
//            path: "Tests/Testing/Snapshot Support"
//        ),

        // MARK: - Tests

        .testTarget(
            name: .htmlRenderingCore.tests,
            dependencies: [
                .htmlRenderingCore,
                .target(name: .htmlRendering),
                .target(name: "HTML Rendering Core Test Support"),
            ],
            path: "Tests/HTML Rendering Core Tests"
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
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
