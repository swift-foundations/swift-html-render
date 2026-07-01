////
////  Set<String> Tests.swift
////  swift-html-rendering
////
////  Created by Coen ten Thije Boonkkamp on 25/11/2025.
////
//
// @testable import HTML_Rendering_Core
// import HTML_Rendering_Core_Test_Support
// import Testing
//
//// @Suite
// struct `HTML.Tag.Inline Tests` {
//
//    // MARK: - Inline Tags
//
//    @Test
//    func `Inline enum contains expected elements`() {
//        // Text formatting
//        #expect(tag("b") != nil)
//        #expect(tag("i") != nil)
//        #expect(tag("strong") != nil)
//        #expect(tag("em") != nil)
//        #expect(tag("u") != nil)
//        #expect(tag("s") != nil)
//        #expect(tag("small") != nil)
//        #expect(tag("mark") != nil)
//
//        // Code and technical
//        #expect(tag("code") != nil)
//        #expect(tag("kbd") != nil)
//        #expect(tag("samp") != nil)
//        #expect(tag("var") != nil)
//
//        // Links and references
//        #expect(tag("a") != nil)
//        #expect(tag("abbr") != nil)
//        #expect(tag("cite") != nil)
//        #expect(tag("q") != nil)
//        #expect(tag("dfn") != nil)
//
//        // Edits
//        #expect(tag("del") != nil)
//        #expect(tag("ins") != nil)
//
//        // Form elements (inline)
//        #expect(tag("button") != nil)
//        #expect(tag("input") != nil)
//        #expect(tag("label") != nil)
//        #expect(tag("select") != nil)
//        #expect(tag("textarea") != nil)
//        #expect(tag("output") != nil)
//
//        // Media
//        #expect(tag("img") != nil)
//
//        // Other
//        #expect(tag("br") != nil)
//        #expect(tag("span") != nil)
//        #expect(tag("script") != nil)
//        #expect(tag("time") != nil)
//    }
//
//    @Test
//    func `Inline enum does not contain block elements`() {
//        // Block elements should NOT be recognized as inline
//        #expect(tag("div") == nil)
//        #expect(tag("p") == nil)
//        #expect(tag("h1") == nil)
//        #expect(tag("h2") == nil)
//        #expect(tag("h3") == nil)
//        #expect(tag("section") == nil)
//        #expect(tag("article") == nil)
//        #expect(tag("header") == nil)
//        #expect(tag("footer") == nil)
//        #expect(tag("nav") == nil)
//        #expect(tag("aside") == nil)
//        #expect(tag("main") == nil)
//        #expect(tag("ul") == nil)
//        #expect(tag("ol") == nil)
//        #expect(tag("li") == nil)
//        #expect(tag("table") == nil)
//        #expect(tag("tr") == nil)
//        #expect(tag("td") == nil)
//        #expect(tag("th") == nil)
//        #expect(tag("form") == nil)
//        #expect(tag("fieldset") == nil)
//        #expect(tag("blockquote") == nil)
//        #expect(tag("pre") == nil)
//    }
//
//    // MARK: - Edge Cases
//
//    @Test
//    func `Inline with case sensitivity`() {
//        // HTML tags are lowercase
//        #expect(tag("span") != nil)
//        #expect(tag("SPAN") == nil)
//        #expect(tag("Span") == nil)
//    }
//
//    @Test
//    func `Inline with empty string`() {
//        #expect(tag("") == nil)
//    }
// }
