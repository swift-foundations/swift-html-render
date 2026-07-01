//
//  AtRule Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

import HTML_Rendering_Core
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

extension HTML.AtRule {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
        @Suite struct Integration {}
    }
}

// MARK: - Unit

extension HTML.AtRule.Test.Unit {

    @Test
    func `basic initialization`() {
        let atRule = HTML.AtRule(rawValue: "@media print")
        #expect(atRule.rawValue == "@media print")
    }

    @Test
    func `complex media query`() {
        let atRule = HTML.AtRule(rawValue: "@media (min-width: 768px) and (max-width: 1024px)")
        #expect(atRule.rawValue == "@media (min-width: 768px) and (max-width: 1024px)")
    }

    @Test
    func `screen media`() {
        let atRule = HTML.AtRule(rawValue: "@media screen")
        #expect(atRule.rawValue == "@media screen")
    }

    @Test
    func `RawRepresentable conformance`() {
        let atRule = HTML.AtRule(rawValue: "@media (hover: hover)")
        let recreated = HTML.AtRule(rawValue: atRule.rawValue)
        #expect(atRule == recreated)
    }

    @Test
    func `equality - same values`() {
        let atRule1 = HTML.AtRule(rawValue: "@media print")
        let atRule2 = HTML.AtRule(rawValue: "@media print")
        #expect(atRule1 == atRule2)
    }

    @Test
    func `equality - different values`() {
        let atRule1 = HTML.AtRule(rawValue: "@media print")
        let atRule2 = HTML.AtRule(rawValue: "@media screen")
        #expect(atRule1 != atRule2)
    }

    @Test
    func `deduplication`() {
        let print1 = HTML.AtRule(rawValue: "@media print")
        let screen = HTML.AtRule(rawValue: "@media screen")
        let printDuplicate = HTML.AtRule(rawValue: "@media print")

        let atRules: [HTML.AtRule] = [print1, screen, printDuplicate]
        var seen: [HTML.AtRule] = []
        for rule in atRules {
            if !seen.contains(where: { $0 == rule }) {
                seen.append(rule)
            }
        }

        #expect(seen.count == 2)
    }

    @Test
    func `is Sendable`() async {
        let atRule = HTML.AtRule(rawValue: "@media print")

        let result = await Task {
            atRule.rawValue
        }.value

        #expect(result == "@media print")
    }

    @Test
    func `prefers-color-scheme dark`() {
        let atRule = HTML.AtRule(rawValue: "@media (prefers-color-scheme: dark)")
        #expect(atRule.rawValue.contains("prefers-color-scheme"))
        #expect(atRule.rawValue.contains("dark"))
    }

    @Test
    func `prefers-reduced-motion`() {
        let atRule = HTML.AtRule(rawValue: "@media (prefers-reduced-motion: reduce)")
        #expect(atRule.rawValue.contains("prefers-reduced-motion"))
    }

    @Test
    func `orientation`() {
        let landscape = HTML.AtRule(rawValue: "@media (orientation: landscape)")
        let portrait = HTML.AtRule(rawValue: "@media (orientation: portrait)")
        #expect(landscape.rawValue.contains("landscape"))
        #expect(portrait.rawValue.contains("portrait"))
    }

    @Test
    func `min-width breakpoint`() {
        let atRule = HTML.AtRule(rawValue: "@media (min-width: 1200px)")
        #expect(atRule.rawValue == "@media (min-width: 1200px)")
    }

    @Test
    func `max-width breakpoint`() {
        let atRule = HTML.AtRule(rawValue: "@media (max-width: 576px)")
        #expect(atRule.rawValue == "@media (max-width: 576px)")
    }

    @Test
    func `combined breakpoints`() {
        let atRule = HTML.AtRule(rawValue: "@media (min-width: 768px) and (max-width: 991px)")
        #expect(atRule.rawValue.contains("min-width"))
        #expect(atRule.rawValue.contains("max-width"))
    }
}

// MARK: - Integration

extension HTML.AtRule.Test.Integration {

    @Test
    func `used with Style`() {
        let atRule = HTML.AtRule(rawValue: "@media print")
        let style = HTML.Element.Style(declaration: "display:none", atRule: atRule)

        #expect(style.atRule == atRule)
        #expect(style.declaration == "display:none")
    }

    @Test
    func `as lookup key`() {
        let print = HTML.AtRule(rawValue: "@media print")
        let screen = HTML.AtRule(rawValue: "@media screen")

        let styles: [(key: HTML.AtRule, value: String)] = [
            (print, "display: none"),
            (screen, "display: block"),
        ]

        #expect(styles.first(where: { $0.key == print })?.value == "display: none")
        #expect(styles.first(where: { $0.key == screen })?.value == "display: block")
    }
}
