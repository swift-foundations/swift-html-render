//
//  AtRule mediaTests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import HTML_Snapshot_Test_Support
import Testing

@testable import HTML_Rendering_Core

@Suite
struct `AtRule media Tests` {

    @Test
    func `AtRule media basic creation`() throws {
        let atRule = HTML.AtRule(rawValue: "screen and (max-width: 768px)")

        // Test that media query can be created
        #expect(atRule.rawValue == "screen and (max-width: 768px)")
    }

    @Test
    func `AtRule media with different conditions`() throws {
        let mobileQuery = HTML.AtRule(rawValue: "screen and (max-width: 480px)")
        let tabletQuery = HTML.AtRule(
            rawValue: "screen and (min-width: 481px) and (max-width: 1024px)"
        )
        let desktopQuery = HTML.AtRule(rawValue: "screen and (min-width: 1025px)")

        #expect(mobileQuery.rawValue.contains("max-width: 480px"))
        #expect(tabletQuery.rawValue.contains("min-width: 481px"))
        #expect(desktopQuery.rawValue.contains("min-width: 1025px"))
    }

    @Test
    func `AtRule media with print media`() throws {
        let printQuery = HTML.AtRule(rawValue: "print")

        #expect(printQuery.rawValue == "print")
    }

    @Test
    func `AtRule media with orientation`() throws {
        let portraitQuery = HTML.AtRule(rawValue: "screen and (orientation: portrait)")
        let landscapeQuery = HTML.AtRule(rawValue: "screen and (orientation: landscape)")

        #expect(portraitQuery.rawValue.contains("portrait"))
        #expect(landscapeQuery.rawValue.contains("landscape"))
    }

    @Test
    func `AtRule media with device features`() throws {
        let retinaQuery = HTML.AtRule(rawValue: "screen and (-webkit-min-device-pixel-ratio: 2)")
        let hoverQuery = HTML.AtRule(rawValue: "screen and (hover: hover)")

        #expect(retinaQuery.rawValue.contains("device-pixel-ratio"))
        #expect(hoverQuery.rawValue.contains("hover: hover"))
    }

    @Test
    func `AtRule media equality`() throws {
        let query1 = HTML.AtRule(rawValue: "screen and (max-width: 768px)")
        let query2 = HTML.AtRule(rawValue: "screen and (max-width: 768px)")
        let query3 = HTML.AtRule(rawValue: "screen and (max-width: 1024px)")

        #expect(query1.rawValue == query2.rawValue)
        #expect(query1.rawValue != query3.rawValue)
    }
}

// MARK: - Snapshot Tests

extension `Snapshot Tests` {
    @Suite
    struct AtRuleSnapshotTests {
        @Test
        func `AtRule media snapshot - mobile styles`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        "Mobile content"
                    }
                    .inlineStyle(
                        "color",
                        "blue",
                        atRule: HTML.AtRule(rawValue: "@media (max-width: 768px)")
                    )
                    .inlineStyle(
                        "font-size",
                        "14px",
                        atRule: HTML.AtRule(rawValue: "@media (max-width: 768px)")
                    )
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      @media (max-width: 768px){
                        .font-size-0{font-size:14px}
                        .color-1{color:blue}
                      }
                    </style>
                  </head>
                  <body>
                    <div class="font-size-0 color-1">Mobile content
                    </div>
                  </body>
                </html>
                """
            }
        }

        @Test
        func `AtRule media snapshot - print styles`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        "Print content"
                    }
                    .inlineStyle("display", "none", atRule: HTML.AtRule(rawValue: "@media print"))
                    .inlineStyle("color", "black", atRule: HTML.AtRule(rawValue: "@media print"))
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      @media print{
                        .color-0{color:black}
                        .display-1{display:none}
                      }
                    </style>
                  </head>
                  <body>
                    <div class="color-0 display-1">Print content
                    </div>
                  </body>
                </html>
                """
            }
        }

        @Test
        func `AtRule media snapshot - mixed media queries`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        tag("h1") { "Responsive Title" }
                            .inlineStyle(
                                "font-size",
                                "24px",
                                atRule: HTML.AtRule(rawValue: "@media (min-width: 768px)")
                            )
                            .inlineStyle(
                                "font-size",
                                "18px",
                                atRule: HTML.AtRule(rawValue: "@media (max-width: 767px)")
                            )

                        tag("p") { "This paragraph adapts to different screen sizes" }
                            .inlineStyle(
                                "margin",
                                "1rem",
                                atRule: HTML.AtRule(rawValue: "@media (min-width: 768px)")
                            )
                            .inlineStyle(
                                "margin",
                                "0.5rem",
                                atRule: HTML.AtRule(rawValue: "@media (max-width: 767px)")
                            )
                            .inlineStyle(
                                "display",
                                "none",
                                atRule: HTML.AtRule(rawValue: "@media print")
                            )
                    }
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      @media (max-width: 767px){
                        .font-size-0{font-size:18px}
                        .margin-3{margin:0.5rem}
                      }
                      @media (min-width: 768px){
                        .font-size-1{font-size:24px}
                        .margin-4{margin:1rem}
                      }
                      @media print{
                        .display-2{display:none}
                      }
                    </style>
                  </head>
                  <body>
                    <div>
                      <h1 class="font-size-0 font-size-1">Responsive Title
                      </h1>
                      <p class="display-2 margin-3 margin-4">This paragraph adapts to different screen sizes
                      </p>
                    </div>
                  </body>
                </html>
                """
            }
        }

        @Test
        func `AtRule media snapshot - no media query`() {
            snapshot(as: .html) {
                HTML.Document {
                    tag("div") {
                        "Regular content without media queries"
                    }
                    .inlineStyle("color", "red")
                    .inlineStyle("padding", "1rem")
                }
            } matches: {
                """
                <!doctype html>
                <html>
                  <head>
                    <style>
                      .padding-0{padding:1rem}
                      .color-1{color:red}
                    </style>
                  </head>
                  <body>
                    <div class="padding-0 color-1">Regular content without media queries
                    </div>
                  </body>
                </html>
                """
            }
        }
    }
}

enum AtRule2 {
    case rule(String)
    indirect case nested(String, AtRule2)
}
