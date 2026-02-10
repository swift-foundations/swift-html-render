//
//  HTML.Context.swift
//  swift-html-rendering
//
//  Rendering context for HTML streaming.
//  Holds state (attributes, styles, indentation) separate from the output buffer.
//

import ASCII
public import OrderedCollections
import Rendering
public import WHATWG_HTML_Shared

extension HTML {
    /// Rendering context for HTML streaming.
    ///
    /// `HTML.Context` holds the state needed during HTML rendering, separate from the output buffer.
    /// This separation enables streaming rendering where the buffer can be any `RangeReplaceableCollection<UInt8>`.
    ///
    /// ## Design Philosophy
    ///
    /// The rendering state is decoupled from the output destination:
    /// - **Context**: Attributes, styles, indentation, rendering configuration
    /// - **Buffer**: Where bytes are written (generic, caller-controlled)
    ///
    /// This enables the same rendering logic to write to `[UInt8]`, `ContiguousArray<UInt8>`,
    /// `Data`, `ByteBuffer`, or any other byte buffer.
    public struct Context: Sendable {
        /// The current set of attributes to apply to the next HTML element.
        public var attributes: OrderedDictionary<String, String>

        /// The collected styles mapped to their generated class names.
        /// Style → className (e.g., HTML.Element.Style(Color.red) → "color-0")
        public var styles: OrderedDictionary<HTML.Element.Style, String>

        /// Configuration for rendering, including formatting options.
        public let configuration: Configuration

        /// The current indentation level for pretty-printing.
        public var currentIndentation: [UInt8]

        /// Counter for generating sequential class names.
        /// Each render context starts at 0, ensuring deterministic naming.
        private var styleCounter: Int
    }
}

extension HTML.Context {
    /// Creates a new HTML rendering context with the specified rendering configuration.
    ///
    /// - Parameter configuration: The rendering configuration to use. Defaults to current task-local value.
    public init(_ configuration: Configuration = .current) {
        self.attributes = [:]
        self.styles = [:]
        self.configuration = configuration
        self.currentIndentation = []
        self.styleCounter = 0
    }
}

extension HTML.Context {
    // MARK: - Style Push API

    /// Push a style to the context and get its class name.
    ///
    /// Same style always returns same class name within a render context.
    /// Class names are descriptive and sequential: `color-0`, `margin-1`, etc.
    ///
    /// - Parameter style: The style to register.
    /// - Returns: A deterministic class name for the style.
    public mutating func pushStyle(
        _ style: HTML.Element.Style
    ) -> String {
        if let existing = styles[style] {
            return existing
        }
        let className = "\(style.propertyName)-\(styleCounter)"
        styleCounter += 1
        styles[style] = className
        return className
    }
}

extension HTML.Context {
    /// Generates a CSS stylesheet from the collected styles as bytes.
    ///
    /// This is the canonical implementation - generates bytes directly without
    /// intermediate String allocation.
    ///
    /// - Parameter baseIndentation: The base indentation to apply to all CSS rules.
    ///   This should match the indentation level of the containing `<style>` tag's content.
    /// - Returns: The stylesheet bytes with proper indentation.
    public func stylesheetBytes(baseIndentation: [UInt8] = []) -> ContiguousArray<UInt8> {
        // Group styles by atRule
        var grouped: OrderedDictionary<HTML.AtRule?, [(style: HTML.Element.Style, className: String)]> = [:]
        for (style, className) in styles {
            grouped[style.atRule, default: []].append((style, className))
        }

        var sheet = ContiguousArray<UInt8>()
        let sortedGroups = grouped.sorted(by: { $0.key == nil ? $1.key != nil : false })

        for (atRule, stylesForAtRule) in sortedGroups {
            if let atRule {
                sheet.append(contentsOf: configuration.newline)
                sheet.append(contentsOf: baseIndentation)
                sheet.append(contentsOf: atRule.rawValue.utf8)
                sheet.append(.ascii.leftBrace)
            }

            for (style, className) in stylesForAtRule {
                // Build selector: [selector] .className[:pseudo]
                var selector = ""
                if let pre = style.selector?.rawValue {
                    selector.append(pre)
                    selector.append(" ")
                }
                selector.append(".")
                selector.append(className)
                if let pseudo = style.pseudo?.rawValue {
                    selector.append(pseudo)
                }

                sheet.append(contentsOf: configuration.newline)
                sheet.append(contentsOf: baseIndentation)
                if atRule != nil {
                    sheet.append(contentsOf: configuration.indentation)
                }
                sheet.append(contentsOf: selector.utf8)
                sheet.append(.ascii.leftBrace)
                sheet.append(contentsOf: style.declaration.utf8)
                if configuration.forceImportant {
                    sheet.append(
                        contentsOf: [.ascii.space] + .html.important
                    )
                }
                sheet.append(.ascii.rightBrace)
            }

            if atRule != nil {
                sheet.append(contentsOf: configuration.newline)
                sheet.append(contentsOf: baseIndentation)
                sheet.append(.ascii.rightBrace)
            }
        }
        return sheet
    }

    /// Generates a CSS stylesheet from the collected styles as bytes.
    ///
    /// Convenience property that calls `stylesheetBytes(baseIndentation:)` with no indentation.
    public var stylesheetBytes: ContiguousArray<UInt8> {
        stylesheetBytes(baseIndentation: [])
    }

    /// Generates a CSS stylesheet from the collected styles.
    ///
    /// Convenience property that converts bytes to String.
    /// Prefer `stylesheetBytes` for performance-critical code.
    public var stylesheet: String {
        String(decoding: stylesheetBytes, as: UTF8.self)
    }
}

extension HTML {
    static let important: [UInt8] = [
        .ascii.exclamationPoint,
        .ascii.i,
        .ascii.m,
        .ascii.p,
        .ascii.o,
        .ascii.r,
        .ascii.t,
        .ascii.a,
        .ascii.n,
        .ascii.t,
    ]
}
