// swift-tools-version: 6.2

import PackageDescription

extension String {
    static let htmlRenderable: Self = "HTML Renderable"
    static let htmlAttributesRendering: Self = "HTML Attributes Rendering"
    static let htmlElementsRendering: Self = "HTML Elements Rendering"
    static let htmlRendering: Self = "HTML Rendering"
    static let htmlRenderableTestSupport: Self = "HTML Rendering TestSupport"
}

extension Target.Dependency {
    static var htmlRenderable: Self { .target(name: .htmlRenderable) }
    static var htmlAttributesRendering: Self { .target(name: .htmlAttributesRendering) }
    static var htmlElementsRendering: Self { .target(name: .htmlElementsRendering) }
    static var htmlRenderableTestSupport: Self { .target(name: .htmlRenderableTestSupport) }
}

extension Target.Dependency {
    static var renderable: Self {
        .product(name: "Rendering", package: "swift-renderable")
    }
    static var asyncRenderable: Self {
        .product(name: "RenderingAsync", package: "swift-renderable")
    }
    static var renderableTestSupport: Self {
        .product(name: "Rendering TestSupport", package: "swift-renderable")
    }
    static var inlineSnapshotTesting: Self {
        .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing")
    }
    static var ascii: Self {
        .product(name: "ASCII", package: "swift-ascii")
    }
    static var iso9899: Self {
        .product(name: "ISO 9899", package: "swift-iso-9899")
    }
    static var standards: Self {
        .product(name: "Standards", package: "swift-standards")
    }
    static var asyncAlgorithms: Self {
        .product(name: "AsyncAlgorithms", package: "swift-async-algorithms-fork")
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
    static var w3cCSSShared: Self {
        .product(name: "W3C CSS Shared", package: "swift-w3c-css")
    }
}

let package = Package(
    name: "swift-html-rendering",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .macCatalyst(.v26),
    ],
    products: [
        .library(name: .htmlRenderable, targets: [.htmlRenderable]),
        .library(name: .htmlAttributesRendering, targets: [.htmlAttributesRendering]),
        .library(name: .htmlElementsRendering, targets: [.htmlElementsRendering]),
        .library(name: .htmlRendering, targets: [.htmlRendering]),
        .library(name: .htmlRenderableTestSupport, targets: [.htmlRenderableTestSupport]),
    ],
    dependencies: [
        .package(path: "../swift-renderable"),
        .package(url: "https://github.com/coenttb/swift-async-algorithms-fork.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.18.3"),
        .package(path: "../../swift-foundations/swift-ascii"),
        .package(path: "../../swift-standards/swift-standards"),
        .package(path: "../../swift-standards/swift-iso-9899"),
        .package(path: "../../swift-standards/swift-html-standard"),
        .package(path: "../../swift-standards/swift-w3c-css"),
    ],
    targets: [
        .target(
            name: .htmlRenderable,
            dependencies: [
                .renderable,
                .asyncRenderable,
                .asyncAlgorithms,
                .product(name: "OrderedCollections", package: "swift-collections"),
                .ascii,
                .standards,
                .iso9899,
                .w3cCSSShared,
                .htmlStandard,
            ]
        ),
        .target(
            name: .htmlAttributesRendering,
            dependencies: [
                .htmlStandard,
                .htmlRenderable,
                .htmlStandardAttributes,
            ]
        ),
        .target(
            name: .htmlElementsRendering,
            dependencies: [
                .htmlStandard,
                .htmlAttributesRendering,
                .htmlStandardElements,
            ]
        ),
        .target(
            name: .htmlRendering,
            dependencies: [
                .htmlStandard,
                .htmlAttributesRendering,
                .htmlElementsRendering,
            ]
        ),
        .target(
            name: .htmlRenderableTestSupport,
            dependencies: [
                .htmlRenderable,
                .renderableTestSupport,
                .inlineSnapshotTesting,
            ]
        ),
        .testTarget(
            name: .htmlRenderable.tests,
            dependencies: [
                .htmlRenderable,
                .htmlRenderableTestSupport
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportsByDefault")
    ]
}
