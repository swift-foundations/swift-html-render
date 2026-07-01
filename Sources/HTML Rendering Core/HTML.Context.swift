//
//  HTML.Context.swift
//  swift-html-rendering
//
//  Rendering context for HTML. Owns the output buffer and conforms to Render.Context.
//

import ASCII
import Dictionary_Primitives
public import Dictionary_Ordered_Primitives
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {
    /// Rendering context for HTML.
    ///
    /// `HTML.Context` is both the rendering state container and the output destination.
    /// It conforms to `Render.Context`, implementing all 15 semantic methods by writing
    /// proper HTML bytes to its internal buffer.
    ///
    /// ## Design
    ///
    /// The buffer lives inside the context. Entry points create an `HTML.Context`,
    /// call `View._render(view, context: &context)`, then extract the buffer via
    /// `context.bytes`. This ensures a single rendering path through `_render<C>`.
    public struct Context: Sendable {
        // MARK: - Output buffer

        /// The accumulated HTML output bytes.
        public var bytes: ContiguousArray<UInt8>

        // MARK: - HTML-specific state

        /// The current set of attributes to apply to the next HTML element.
        public var attributes: Attributes

        /// The collected styles mapped to their generated class names.
        public var styles: Styles

        /// Configuration for rendering, including formatting options.
        public let configuration: Configuration

        /// The current indentation level for pretty-printing.
        public var currentIndentation: [UInt8]

        /// Counter for generating sequential class names.
        private var styleCounter: Int

        // MARK: - Block/inline state stack

        /// State saved by pushBlock/pushInline for restoration by pop.
        struct SavedState {
            let tag: String
            let isVoid: Bool
            let isBlock: Bool
            let isPreElement: Bool
            let savedAttributes: HTML.Context.Attributes
            let savedIndentation: [UInt8]
        }

        /// Stack of saved states for nested elements.
        var stateStack: [SavedState]
    }
}

// MARK: - Initialization

extension HTML.Context {
    /// Creates a new HTML rendering context.
    ///
    /// - Parameter configuration: The rendering configuration. Defaults to current task-local value.
    public init(_ configuration: Configuration = .current) {
        self.bytes = ContiguousArray<UInt8>()
        self.attributes = HTML.Context.Attributes()
        self.styles = HTML.Context.Styles()
        self.configuration = configuration
        self.currentIndentation = []
        self.styleCounter = 0
        self.stateStack = []
        self.bytes.reserveCapacity(configuration.reservedCapacity)
    }
}

// MARK: - Render.Context conformance

extension HTML.Context {
    public mutating func text(_ content: borrowing String) {
        let copy = copy content
        for byte in copy.utf8 {
            switch byte {
            case .ascii.ampersand:
                bytes.append(contentsOf: [UInt8].html.ampersand)
            case .ascii.lessThanSign:
                bytes.append(contentsOf: [UInt8].html.lessThan)
            case .ascii.greaterThanSign:
                bytes.append(contentsOf: [UInt8].html.greaterThan)
            default:
                bytes.append(byte)
            }
        }
    }

    public static func _pushBlock(_ context: inout Self, role: Render.Semantic.Block?, style: Render.Style) {
        let tag = tagName(forBlock: role)
        let isVoid = isVoidTag(tag)
        let isPreElement = tag == "pre"
        let isPrettyPrinting = !context.configuration.newline.isEmpty

        if isPrettyPrinting {
            if !context.bytes.isEmpty {
                context.bytes.append(contentsOf: context.configuration.newline)
            }
            context.bytes.append(contentsOf: context.currentIndentation)
        }

        context.writeOpeningTag(tag)

        if isVoid {
            context.attributes.removeAll()
            return
        }

        let savedAttributes = context.attributes
        let savedIndentation = context.currentIndentation
        context.attributes.removeAll()

        if isPrettyPrinting && !isPreElement {
            context.currentIndentation += context.configuration.indentation
        }

        context.stateStack.append(SavedState(
            tag: tag,
            isVoid: false,
            isBlock: true,
            isPreElement: isPreElement,
            savedAttributes: savedAttributes,
            savedIndentation: savedIndentation
        ))
    }

    public static func _popBlock(_ context: inout Self) {
        guard let state = context.stateStack.popLast() else { return }
        let isPrettyPrinting = !context.configuration.newline.isEmpty

        context.attributes = state.savedAttributes
        context.currentIndentation = state.savedIndentation

        if isPrettyPrinting && !state.isPreElement {
            context.bytes.append(contentsOf: context.configuration.newline)
            context.bytes.append(contentsOf: context.currentIndentation)
        }
        context.writeClosingTag(state.tag)
    }

    public static func _pushInline(_ context: inout Self, role: Render.Semantic.Inline?, style: Render.Style) {
        let tag = tagName(forInline: role)

        context.writeOpeningTag(tag)

        let savedAttributes = context.attributes
        let savedIndentation = context.currentIndentation
        context.attributes.removeAll()

        context.stateStack.append(SavedState(
            tag: tag,
            isVoid: false,
            isBlock: false,
            isPreElement: false,
            savedAttributes: savedAttributes,
            savedIndentation: savedIndentation
        ))
    }

    public static func _popInline(_ context: inout Self) {
        guard let state = context.stateStack.popLast() else { return }
        context.attributes = state.savedAttributes
        context.currentIndentation = state.savedIndentation
        context.writeClosingTag(state.tag)
    }

    public static func _pushList(_ context: inout Self, kind: Render.Semantic.List, start: Int?) {
        let tag = kind == .ordered ? "ol" : "ul"
        let isPrettyPrinting = !context.configuration.newline.isEmpty

        if isPrettyPrinting {
            if !context.bytes.isEmpty {
                context.bytes.append(contentsOf: context.configuration.newline)
            }
            context.bytes.append(contentsOf: context.currentIndentation)
        }

        context.writeOpeningTag(tag)

        let savedAttributes = context.attributes
        let savedIndentation = context.currentIndentation
        context.attributes.removeAll()

        if isPrettyPrinting {
            context.currentIndentation += context.configuration.indentation
        }

        context.stateStack.append(SavedState(
            tag: tag,
            isVoid: false,
            isBlock: true,
            isPreElement: false,
            savedAttributes: savedAttributes,
            savedIndentation: savedIndentation
        ))
    }

    public static func _popList(_ context: inout Self) {
        _popBlock(&context)
    }

    public static func _pushItem(_ context: inout Self) {
        let isPrettyPrinting = !context.configuration.newline.isEmpty

        if isPrettyPrinting {
            if !context.bytes.isEmpty {
                context.bytes.append(contentsOf: context.configuration.newline)
            }
            context.bytes.append(contentsOf: context.currentIndentation)
        }

        context.writeOpeningTag("li")

        let savedAttributes = context.attributes
        let savedIndentation = context.currentIndentation
        context.attributes.removeAll()

        if isPrettyPrinting {
            context.currentIndentation += context.configuration.indentation
        }

        context.stateStack.append(SavedState(
            tag: "li",
            isVoid: false,
            isBlock: true,
            isPreElement: false,
            savedAttributes: savedAttributes,
            savedIndentation: savedIndentation
        ))
    }

    public static func _popItem(_ context: inout Self) {
        _popBlock(&context)
    }

    public mutating func lineBreak() {
        let isPrettyPrinting = !configuration.newline.isEmpty
        if isPrettyPrinting {
            if !bytes.isEmpty {
                bytes.append(contentsOf: configuration.newline)
            }
            bytes.append(contentsOf: currentIndentation)
        }
        bytes.append(contentsOf: "<br>".utf8)
    }

    public mutating func thematicBreak() {
        let isPrettyPrinting = !configuration.newline.isEmpty
        if isPrettyPrinting {
            if !bytes.isEmpty {
                bytes.append(contentsOf: configuration.newline)
            }
            bytes.append(contentsOf: currentIndentation)
        }
        bytes.append(contentsOf: "<hr>".utf8)
    }

    public mutating func image(source: String, alt: String) {
        let isPrettyPrinting = !configuration.newline.isEmpty
        if isPrettyPrinting {
            if !bytes.isEmpty {
                bytes.append(contentsOf: configuration.newline)
            }
            bytes.append(contentsOf: currentIndentation)
        }
        bytes.append(contentsOf: "<img src=\"".utf8)
        escapeAttributeValue(source)
        bytes.append(contentsOf: "\" alt=\"".utf8)
        escapeAttributeValue(alt)
        bytes.append(contentsOf: "\">".utf8)
    }

    public static func _pushLink(_ context: inout Self, destination: borrowing String) {
        let copy = copy destination
        context.bytes.append(contentsOf: "<a href=\"".utf8)
        context.escapeAttributeValue(copy)
        context.bytes.append(contentsOf: "\">".utf8)

        let savedAttributes = context.attributes
        let savedIndentation = context.currentIndentation
        context.attributes.removeAll()

        context.stateStack.append(SavedState(
            tag: "a",
            isVoid: false,
            isBlock: false,
            isPreElement: false,
            savedAttributes: savedAttributes,
            savedIndentation: savedIndentation
        ))
    }

    public static func _popLink(_ context: inout Self) {
        guard let state = context.stateStack.popLast() else { return }
        context.attributes = state.savedAttributes
        context.currentIndentation = state.savedIndentation
        context.writeClosingTag("a")
    }

    public mutating func pageBreak() {
        let isPrettyPrinting = !configuration.newline.isEmpty
        if isPrettyPrinting {
            if !bytes.isEmpty {
                bytes.append(contentsOf: configuration.newline)
            }
            bytes.append(contentsOf: currentIndentation)
        }
        bytes.append(contentsOf: "<div style=\"page-break-after:always\"></div>".utf8)
    }
}

// MARK: - HTML tag writing helpers

extension HTML.Context {
    /// Write an opening tag with the current attributes.
    mutating func writeOpeningTag(_ tag: String) {
        bytes.append(.ascii.lessThanSign)
        bytes.append(contentsOf: tag.utf8)

        // Write attributes with single-pass escaping. Snapshot the CoW map first so
        // the closure may mutate `self` (bytes / escapeAttributeValue) without
        // overlapping the borrow of `self.attributes`.
        let currentAttributes = attributes
        currentAttributes.forEach { name, value in
            bytes.append(.ascii.space)
            bytes.append(contentsOf: name.utf8)
            if !value.isEmpty {
                bytes.append(.ascii.equalsSign)
                bytes.append(.ascii.dquote)
                escapeAttributeValue(value)
                bytes.append(.ascii.dquote)
            }
        }
        bytes.append(.ascii.greaterThanSign)
    }

    /// Write a closing tag.
    mutating func writeClosingTag(_ tag: String) {
        bytes.append(.ascii.lessThanSign)
        bytes.append(.ascii.slant)
        bytes.append(contentsOf: tag.utf8)
        bytes.append(.ascii.greaterThanSign)
    }

    /// Escape an attribute value directly into the buffer.
    mutating func escapeAttributeValue(_ value: String) {
        for byte in value.utf8 {
            switch byte {
            case .ascii.dquote:
                bytes.append(contentsOf: [UInt8].html.doubleQuotationMark)
            case .ascii.apostrophe:
                bytes.append(contentsOf: [UInt8].html.apostrophe)
            case .ascii.ampersand:
                bytes.append(contentsOf: [UInt8].html.ampersand)
            case .ascii.lessThanSign:
                bytes.append(contentsOf: [UInt8].html.lessThan)
            case .ascii.greaterThanSign:
                bytes.append(contentsOf: [UInt8].html.greaterThan)
            default:
                bytes.append(byte)
            }
        }
    }
}

// MARK: - Semantic role → HTML tag mapping

extension HTML.Context {
    /// Maps a semantic block role to an HTML tag name.
    static func tagName(forBlock role: Render.Semantic.Block?) -> String {
        switch role {
        case .heading(let level): "h\(level)"
        case .paragraph: "p"
        case .blockquote: "blockquote"
        case .section: "section"
        case .pre: "pre"
        case .table: "table"
        case .row: "tr"
        case .cell(header: true): "th"
        case .cell(header: false): "td"
        case nil: "div"
        }
    }

    /// Maps a semantic inline role to an HTML tag name.
    static func tagName(forInline role: Render.Semantic.Inline?) -> String {
        switch role {
        case .emphasis: "em"
        case .strong: "strong"
        case .code: "code"
        case nil: "span"
        }
    }

    /// Whether a tag is a void element (no closing tag).
    static func isVoidTag(_ tag: String) -> Bool {
        switch tag {
        case "area", "base", "br", "col", "embed", "hr", "img",
             "input", "link", "meta", "param", "source", "track", "wbr":
            true
        default:
            false
        }
    }
}

// MARK: - Element method overrides

extension HTML.Context {
    public mutating func set(attribute name: String, _ value: String?) {
        if let value {
            attributes[name] = value
        }
    }

    public mutating func add(`class` name: String) {
        if let existing = attributes["class"] {
            attributes["class"] = existing + " " + name
        } else {
            attributes["class"] = name
        }
    }

    public static func _pushAttributes(_ context: inout Self) {
        context.stateStack.append(SavedState(
            tag: "",
            isVoid: false,
            isBlock: false,
            isPreElement: false,
            savedAttributes: context.attributes,
            savedIndentation: context.currentIndentation
        ))
    }

    public static func _popAttributes(_ context: inout Self) {
        guard let state = context.stateStack.popLast() else { return }
        context.attributes = state.savedAttributes
    }

    public mutating func write(raw bytes: [UInt8]) {
        self.bytes.append(contentsOf: bytes)
    }

    public static func _pushElement(
        _ context: inout Self,
        tagName: String,
        isBlock: Bool,
        isVoid: Bool,
        isPreElement: Bool
    ) {
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        let htmlIsBlock = isPrettyPrinting && isBlock

        // Leading whitespace for block elements
        if htmlIsBlock {
            if !context.bytes.isEmpty {
                context.bytes.append(contentsOf: context.configuration.newline)
            }
            context.bytes.append(contentsOf: context.currentIndentation)
        }

        // Opening tag with attributes
        context.writeOpeningTag(tagName)

        // Save state and prepare for content
        let savedAttributes = context.attributes
        let savedIndentation = context.currentIndentation
        context.attributes.removeAll()

        if isVoid {
            // Void elements still push to the state stack so the balanced
            // _popElement call doesn't steal the parent's entry.
            context.stateStack.append(SavedState(
                tag: tagName,
                isVoid: true,
                isBlock: isBlock,
                isPreElement: isPreElement,
                savedAttributes: savedAttributes,
                savedIndentation: savedIndentation
            ))
            return
        }

        if htmlIsBlock && !isPreElement {
            context.currentIndentation += context.configuration.indentation
        }

        context.stateStack.append(SavedState(
            tag: tagName,
            isVoid: false,
            isBlock: isBlock,
            isPreElement: isPreElement,
            savedAttributes: savedAttributes,
            savedIndentation: savedIndentation
        ))
    }

    public static func _popElement(_ context: inout Self, isBlock: Bool) {
        guard let state = context.stateStack.popLast() else { return }

        // Restore state
        context.attributes = state.savedAttributes
        context.currentIndentation = state.savedIndentation

        // Void elements have no closing tag
        if state.isVoid { return }

        // Closing tag
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        if isPrettyPrinting && state.isBlock && !state.isPreElement {
            context.bytes.append(contentsOf: context.configuration.newline)
            context.bytes.append(contentsOf: context.currentIndentation)
        }
        context.writeClosingTag(state.tag)
    }

    public mutating func register(
        style declaration: String,
        atRule: String?,
        selector: String?,
        pseudo: String?
    ) -> String? {
        let style = HTML.Element.Style(
            declaration: declaration,
            atRule: atRule.map { HTML.AtRule(rawValue: $0) },
            selector: selector.map { HTML.Selector(rawValue: $0) },
            pseudo: pseudo.map { HTML.Pseudo(rawValue: $0) }
        )
        return pushStyle(style)
    }
}

// MARK: - Style API

extension HTML.Context {
    /// Push a style to the context and get its class name.
    ///
    /// Same style always returns same class name within a render context.
    /// Class names are descriptive and sequential: `color-0`, `margin-1`, etc.
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

// MARK: - Stylesheet generation

extension HTML.Context {
    /// Generates a CSS stylesheet from the collected styles as bytes.
    public func stylesheetBytes(baseIndentation: [UInt8] = []) -> ContiguousArray<UInt8> {
        // Group styles by atRule
        var grouped: [HTML.AtRule?: [(style: HTML.Element.Style, className: String)]] = [:]
        styles.forEach { style, className in
            grouped[style.atRule, default: []].append((style, className))
        }

        var sheet = ContiguousArray<UInt8>()
        let sortedGroups = Array(grouped).sorted(by: { $0.key == nil ? $1.key != nil : false })

        for (atRule, stylesForAtRule) in sortedGroups {
            if let atRule {
                sheet.append(contentsOf: configuration.newline)
                sheet.append(contentsOf: baseIndentation)
                sheet.append(contentsOf: atRule.rawValue.utf8)
                sheet.append(.ascii.leftBrace)
            }

            for (style, className) in stylesForAtRule {
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

    /// Convenience property for stylesheet bytes with no indentation.
    public var stylesheetBytes: ContiguousArray<UInt8> {
        stylesheetBytes(baseIndentation: [])
    }

    /// Convenience property that converts bytes to String.
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
