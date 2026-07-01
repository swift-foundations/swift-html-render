//
//  HTMLElement Tag Storage Performance Tests.swift
//  swift-html-rendering
//
//  A/B comparison: class-backed indirect storage vs inline storage
//  for HTML.Element.Tag<Content>.
//
//  Indirect storage keeps Tag at pointer size (8 bytes) regardless of content,
//  preventing cooperative pool stack overflow during result builder expansion.
//  These tests measure the allocation overhead trade-off.
//

import HTML_Snapshot_Test_Support
import Testing
import Tests_Performance

@testable import HTML_Rendering_Core

// MARK: - Inline Baseline

/// Mirrors the original `HTML.Element.Tag` layout with inline storage.
/// Used as a measurement control — not connected to the rendering pipeline.
private struct InlineTag<Content> {
    let tagName: String
    let isBlock: Bool
    let isVoid: Bool
    let isPreElement: Bool
    let content: Content?
}

extension InlineTag: Sendable where Content: Sendable {}

// MARK: - Tests

extension `Performance Tests` {

    @Suite(.serialized)
    struct `Tag Storage` {

        // MARK: - Tag Creation (isolates allocation overhead)

        @Test(.timed(iterations: 3))
        func `inline tag creation 100K`() {
            for _ in 0..<100_000 {
                let t = InlineTag<String>(
                    tagName: "div", isBlock: true, isVoid: false,
                    isPreElement: false, content: "Hello"
                )
                blackHole(t)
            }
        }

        @Test(.timed(iterations: 3))
        func `indirect tag creation 100K`() {
            for _ in 0..<100_000 {
                let t = HTML.Element.Tag<String>(
                    tag: "div"
                ) { "Hello" }
                blackHole(t)
            }
        }

        // MARK: - Tag Copy (retain vs memcpy)

        @Test(.timed(iterations: 3))
        func `inline tag copy 100K`() {
            let source = InlineTag<String>(
                tagName: "div", isBlock: true, isVoid: false,
                isPreElement: false, content: "Hello"
            )
            for _ in 0..<100_000 {
                let copy = source
                blackHole(copy)
            }
        }

        @Test(.timed(iterations: 3))
        func `indirect tag copy 100K`() {
            let source = HTML.Element.Tag<String>(
                tag: "div"
            ) { "Hello" }
            for _ in 0..<100_000 {
                let copy = source
                blackHole(copy)
            }
        }

        // MARK: - Large Content Tag (where indirect wins on copy)

        @Test(.timed(iterations: 3))
        func `inline tag copy with large content 100K`() {
            let source = InlineTag<(String, String, String, String, String, String)>(
                tagName: "table", isBlock: true, isVoid: false,
                isPreElement: false,
                content: ("Row 1", "Row 2", "Row 3", "Row 4", "Row 5", "Row 6")
            )
            for _ in 0..<100_000 {
                let copy = source
                blackHole(copy)
            }
        }

        @Test(.timed(iterations: 3))
        func `indirect tag copy with large content 100K`() {
            let source = tag("table") {
                tag("tr") { "Row 1" }
                tag("tr") { "Row 2" }
                tag("tr") { "Row 3" }
                tag("tr") { "Row 4" }
                tag("tr") { "Row 5" }
                tag("tr") { "Row 6" }
            }
            for _ in 0..<100_000 {
                let copy = source
                blackHole(copy)
            }
        }

        // MARK: - Full Document Rendering (end-to-end throughput)

        @Test(.timed(iterations: 3))
        func `small document 1K renders`() {
            for _ in 0..<1_000 {
                _ = try! String(
                    HTML.Document {
                        tag("div") {
                            tag("h1") { "Title" }
                            tag("p") { "Paragraph one." }
                            tag("p") { "Paragraph two." }
                        }
                    }
                )
            }
        }

        @Test(.timed(iterations: 3))
        func `table document 100 renders - 6 rows`() {
            for _ in 0..<100 {
                _ = try! String(
                    HTML.Document {
                        tag("table") {
                            tag("tbody") {
                                for i in 0..<6 {
                                    tag("tr") {
                                        tag("td") { "Label \(i)" }
                                        tag("td") { "Value \(i)" }
                                    }
                                }
                            }
                        }
                    }
                )
            }
        }

        @Test(.timed(iterations: 3))
        func `table document 100 renders - 20 rows`() {
            for _ in 0..<100 {
                _ = try! String(
                    HTML.Document {
                        tag("table") {
                            tag("tbody") {
                                for i in 0..<20 {
                                    tag("tr") {
                                        tag("td") { "Label \(i)" }
                                        tag("td") { ": Value \(i)" }
                                    }
                                }
                            }
                        }
                    }
                )
            }
        }

        @Test(.timed(iterations: 3))
        func `nested sections 50 renders - register-like`() {
            for _ in 0..<50 {
                _ = try! String(
                    HTML.Document {
                        tag("section") {
                            tag("h1") { "GEGEVENS PER AANDEELHOUDER" }
                            tag("h3") { "AANDEELHOUDER" }

                            tag("table") {
                                tag("tbody") {
                                    for label in ["naam", "adres", "e-mailadres", "geboren te", "KvK-nummer", "wijziging"] {
                                        tag("tr") {
                                            tag("td") { label }
                                            tag("td") { ": " }
                                        }
                                    }
                                }
                            }

                            tag("h3") { "EERSTE INSCHRIJVING" }

                            tag("table") {
                                tag("tbody") {
                                    for label in ["rechtsfeit", "notaris", "aantal", "nominaal", "nummers", "gestort"] {
                                        tag("tr") {
                                            tag("td") { label }
                                            tag("td") { ": " }
                                        }
                                    }
                                }
                            }

                            tag("table") {
                                tag("tbody") {
                                    for label in ["datum verkrijging", "datum erkenning", "datum inschrijving"] {
                                        tag("tr") {
                                            tag("td") { label }
                                            tag("td") { ": " }
                                        }
                                    }
                                }
                            }
                        }

                        tag("section") {
                            tag("h1") { "MUTATIE" }

                            tag("table") {
                                tag("tbody") {
                                    for label in ["rechtsfeit", "notaris", "datum", "aantal", "nominaal", "nummers"] {
                                        tag("tr") {
                                            tag("td") { label }
                                            tag("td") { ": " }
                                        }
                                    }
                                }
                            }

                            tag("table") {
                                tag("tbody") {
                                    for label in ["gehouden na mutatie", "aantal", "nominaal", "nummers"] {
                                        tag("tr") {
                                            tag("td") { label }
                                            tag("td") { ": " }
                                        }
                                    }
                                }
                            }

                            tag("table") {
                                tag("tbody") {
                                    for label in ["datum inschrijving", "BIJZONDERHEDEN"] {
                                        tag("tr") {
                                            tag("td") { label }
                                            tag("td") { ": " }
                                        }
                                    }
                                }
                            }
                        }
                    }
                )
            }
        }

        @Test(.timed(iterations: 3))
        func `wide flat document 50 renders - 100 elements`() {
            for _ in 0..<50 {
                _ = try! String(
                    HTML.Document {
                        tag("div") {
                            for i in 0..<100 {
                                tag("p") { "Paragraph \(i)" }
                            }
                        }
                    }
                )
            }
        }
    }
}

// MARK: - Black Hole

/// Prevents dead-code elimination without observable side effects.
@inline(never)
private func blackHole<T>(_ value: T) {
    withExtendedLifetime(value) {}
}
