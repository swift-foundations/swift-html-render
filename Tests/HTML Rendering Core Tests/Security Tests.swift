//
//  Security Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//
//  Cross-cutting security tests for XSS prevention and safe HTML generation.
//

@_spi(DynamicHTML) import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `Security Tests` {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `Security Tests`.Unit {

    @Test
    func `script tags in text are escaped`() throws {
        let malicious = "<script>alert('XSS')</script>"
        let html = tag("p") { HTML.Text(malicious) }
        let rendered = try String(html)

        #expect(!rendered.contains("<script>"))
        #expect(rendered.contains("&lt;script&gt;"))
    }

    @Test
    func `script tags with attributes are escaped`() throws {
        let malicious = "<script src=\"evil.js\"></script>"
        let html = tag("div") { HTML.Text(malicious) }
        let rendered = try String(html)

        #expect(!rendered.contains("<script"))
        #expect(rendered.contains("&lt;script"))
    }

    @Test
    func `event handlers in text are escaped`() throws {
        let malicious = "<img src=x onerror=\"alert('XSS')\">"
        let html = tag("div") { HTML.Text(malicious) }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;img"))
        #expect(rendered.contains("&gt;"))
        #expect(!rendered.contains("<img"))
    }

    @Test
    func `JavaScript URLs in text are escaped`() throws {
        let malicious = "<a href=\"javascript:alert('XSS')\">Click</a>"
        let html = tag("div") { HTML.Text(malicious) }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;a"))
        #expect(rendered.contains("&gt;"))
        #expect(!rendered.contains("<a "))
    }

    @Test
    func `double quotes in attribute values are escaped`() throws {
        let malicious = "value\" onclick=\"alert('XSS')"
        let html = tag("input").attribute("value", malicious)
        let rendered = try String(html)

        #expect(rendered.contains("&quot;"))
        #expect(rendered.contains("value=\"value&quot;"))
    }

    @Test
    func `angle brackets in attributes are escaped`() throws {
        let malicious = "<script>alert('XSS')</script>"
        let html = tag("div").attribute("data-content", malicious)
        let rendered = try String(html)

        #expect(!rendered.contains("data-content=\"<script>"))
    }

    @Test
    func `ampersands in attributes are escaped`() throws {
        let url = "/search?q=foo&bar=baz"
        let html = tag("a").attribute("href", url)
        let rendered = try String(html)

        #expect(rendered.contains("&amp;") || rendered.contains("&bar"))
    }

    @Test
    func `HTML entities in text do not execute`() throws {
        let malicious = "&#60;script&#62;alert('XSS')&#60;/script&#62;"
        let html = tag("p") { HTML.Text(malicious) }
        let rendered = try String(html)

        #expect(!rendered.contains("<script>"))
    }

    @Test
    func `hex encoded entities do not execute`() throws {
        let malicious = "&#x3C;script&#x3E;alert('XSS')&#x3C;/script&#x3E;"
        let html = tag("p") { HTML.Text(malicious) }
        let rendered = try String(html)

        #expect(!rendered.contains("<script>"))
    }

    @Test
    func `HTML.Raw is not escaped`() throws {
        let dangerous = "<script>alert('This executes')</script>"
        let html = HTML.Raw(dangerous)
        let rendered = try String(HTML.Group { html })

        #expect(rendered.contains("<script>"))
    }

    @Test
    func `HTML.Raw with trusted content`() throws {
        let trusted = "<strong>Bold text</strong>"
        let html = HTML.Raw(trusted)
        let rendered = try String(HTML.Group { html })

        #expect(rendered.contains("<strong>"))
    }
}

// MARK: - EdgeCase

extension `Security Tests`.EdgeCase {

    @Test
    func `style expression injection`() throws {
        let malicious = "expression(alert('XSS'))"
        let html = tag("div") { HTML.Text("Content") }
            .inlineStyle("color", malicious)
        let rendered = try String(HTML.Document { html })

        #expect(rendered.contains("expression"))
    }

    @Test
    func `URL function in style`() throws {
        let malicious = "url(javascript:alert('XSS'))"
        let html = tag("div") { HTML.Text("Content") }
            .inlineStyle("background", malicious)
        let rendered = try String(HTML.Document { html })

        #expect(rendered.contains("background:"))
    }

    @Test
    func `Unicode escape sequences do not bypass escaping`() throws {
        let malicious = "\\u003cscript\\u003ealert('XSS')\\u003c/script\\u003e"
        let html = tag("p") { HTML.Text(malicious) }
        let rendered = try String(html)

        #expect(rendered.contains("\\u003c"))
    }

    @Test
    func `zero-width characters in text`() throws {
        let sneaky = "scr\u{200B}ipt"
        let html = tag("p") { HTML.Text("<\(sneaky)>alert('XSS')</\(sneaky)>") }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;"))
        #expect(rendered.contains("&gt;"))
    }

    @Test
    func `single quotes in double-quoted attributes`() throws {
        let value = "It's a test"
        let html = tag("div").attribute("title", value)
        let rendered = try String(html)

        #expect(rendered.contains("title=\"It's a test\"") || rendered.contains("It&#39;s"))
    }

    @Test
    func `newlines in attributes`() throws {
        let value = "Line 1\nLine 2"
        let html = tag("div").attribute("data-content", value)
        let rendered = try String(html)

        #expect(rendered.contains("data-content="))
    }

    @Test
    func `nested script tags`() throws {
        let payload = "<<script>script>alert('XSS')<</script>/script>"
        let html = tag("p") { HTML.Text(payload) }
        let rendered = try String(html)

        #expect(!rendered.contains("<script>"))
    }

    @Test
    func `mixed case script tag`() throws {
        let payload = "<ScRiPt>alert('XSS')</ScRiPt>"
        let html = tag("p") { HTML.Text(payload) }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;ScRiPt&gt;"))
    }
}

// MARK: - Integration

extension `Security Tests`.Integration {

    @Test
    func `IMG onerror payload`() throws {
        let payload = "<IMG SRC=x onerror=\"alert('XSS')\">"
        let html = tag("div") { HTML.Text(payload) }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;IMG"))
        #expect(!rendered.contains("<IMG"))
    }

    @Test
    func `SVG onload payload`() throws {
        let payload = "<svg onload=\"alert('XSS')\">"
        let html = tag("div") { HTML.Text(payload) }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;svg"))
    }

    @Test
    func `body onload payload`() throws {
        let payload = "<body onload=\"alert('XSS')\">"
        let html = tag("div") { HTML.Text(payload) }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;body"))
    }

    @Test
    func `iframe payload`() throws {
        let payload = "<iframe src=\"javascript:alert('XSS')\">"
        let html = tag("div") { HTML.Text(payload) }
        let rendered = try String(html)

        #expect(rendered.contains("&lt;iframe"))
    }

    @Test
    func `HTML document sets proper structure`() throws {
        let document = HTML.Document {
            tag("p") { HTML.Text("Content") }
        }
        let rendered = try String(document)

        #expect(rendered.contains("<!doctype html>"))
        #expect(rendered.contains("<html>"))
    }
}
