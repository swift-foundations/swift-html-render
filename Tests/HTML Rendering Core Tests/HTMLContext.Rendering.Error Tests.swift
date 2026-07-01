//
//  HTMLContext.Rendering.Error Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

@_spi(DynamicHTML) import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

extension HTML.Context.Configuration.Error {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
        @Suite struct Integration {}
    }
}

// MARK: - Unit

extension HTML.Context.Configuration.Error.Test.Unit {

    @Test
    func `initialization with message`() {
        let error = HTML.Context.Configuration.Error(message: "Failed to render HTML")
        #expect(error.message == "Failed to render HTML")
    }

    @Test
    func `conforms to Swift.Error`() {
        let error: any Swift.Error = HTML.Context.Configuration.Error(message: "Test error")
        #expect(error is HTML.Context.Configuration.Error)
    }

    @Test
    func `can be thrown and caught`() {
        func throwingFunction() throws {
            throw HTML.Context.Configuration.Error(message: "Intentional error")
        }

        do {
            try throwingFunction()
            #expect(Bool(false), "Expected error to be thrown")
        } catch let error as HTML.Context.Configuration.Error {
            #expect(error.message == "Intentional error")
        } catch {
            #expect(Bool(false), "Unexpected error type: \(type(of: error))")
        }
    }

    @Test
    func `descriptive message`() {
        let error = HTML.Context.Configuration.Error(
            message: "Invalid UTF-8 sequence at byte offset 42"
        )
        #expect(error.message.contains("UTF-8"))
        #expect(error.message.contains("42"))
    }

    @Test
    func `can be handled with do-catch`() {
        let error = HTML.Context.Configuration.Error(message: "Test")

        do {
            throw error
        } catch {
            #expect(error is HTML.Context.Configuration.Error)
        }
    }

    @Test
    func `can be used with Result type`() {
        let result: Result<String, HTML.Context.Configuration.Error> = .failure(
            HTML.Context.Configuration.Error(message: "Rendering failed")
        )

        switch result {
        case .success:
            #expect(Bool(false), "Expected failure")
        case .failure(let error):
            #expect(error.message == "Rendering failed")
        }
    }

    @Test
    func `can be used with async throws`() async {
        func asyncRenderer() async throws -> String {
            throw HTML.Context.Configuration.Error(message: "Async rendering failed")
        }

        do {
            _ = try await asyncRenderer()
            #expect(Bool(false), "Expected error")
        } catch let error as HTML.Context.Configuration.Error {
            #expect(error.message == "Async rendering failed")
        } catch {
            #expect(Bool(false), "Wrong error type")
        }
    }
}

// MARK: - EdgeCase

extension HTML.Context.Configuration.Error.Test.EdgeCase {

    @Test
    func `empty message`() {
        let error = HTML.Context.Configuration.Error(message: "")
        #expect(error.message.isEmpty)
    }

    @Test
    func `multiline message`() {
        let message = """
            Rendering failed:
            - Invalid attribute value
            - Missing closing tag
            """
        let error = HTML.Context.Configuration.Error(message: message)
        #expect(error.message.contains("Rendering failed"))
        #expect(error.message.contains("Invalid attribute"))
        #expect(error.message.contains("Missing closing tag"))
    }

    @Test
    func `message preserves special characters`() {
        let error = HTML.Context.Configuration.Error(message: "Error with <html> & \"quotes\"")
        #expect(error.message.contains("<html>"))
        #expect(error.message.contains("&"))
        #expect(error.message.contains("\"quotes\""))
    }

    @Test
    func `message preserves Unicode`() {
        let error = HTML.Context.Configuration.Error(message: "Error: \u{65E5}\u{672C}\u{8A9E} \u{1F6AB}")
        #expect(error.message.contains("\u{65E5}\u{672C}\u{8A9E}"))
        #expect(error.message.contains("\u{1F6AB}"))
    }
}

// MARK: - Integration

extension HTML.Context.Configuration.Error.Test.Integration {

    @Test
    func `String initializer succeeds for valid content`() throws {
        let document = HTML.Document {
            tag("div") {
                HTML.Text("Valid content")
            }
        }

        let result = try String(document)
        #expect(result.contains("Valid content"))
    }
}
