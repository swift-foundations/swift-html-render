import Dictionary_Ordered_Primitives
import Ownership_Mutable_Primitives
import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public protocol __DocumentProtocol: HTML.View {
        associatedtype Head: HTML.View

        @HTML.Builder
        var head: Head { get }
    }
}

extension HTML.__DocumentProtocol {

    public static func _render(
        _ html: borrowing Self,
        context: inout Render.Context
    ) {
        context.render(html.head)
        context.render(html.body)
    }

    public static func _renderHTMLDocument(
        _ html: borrowing Self,
        context: inout HTML.Context
    ) {
        let configuration = context.configuration
        let indent = configuration.indentation

        let bodyState = Ownership.Mutable(HTML.Context(configuration))
        bodyState.value.currentIndentation = indent + indent
        var bodyRenderCtx = Render.Context.html(state: bodyState)
        bodyRenderCtx.render(html.body)
        let bodyBytes = bodyState.value.bytes

        bodyState.value.styles.forEach { key, value in
            context.styles[key] = value
        }

        let newline = configuration.newline

        let contentIndent = indent + indent

        context.bytes.append(contentsOf: [UInt8].html.tag.doctype)

        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: [UInt8].html.tag.open)

        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.headOpen)

        let headState = Ownership.Mutable(HTML.Context(configuration))
        headState.value.currentIndentation = indent + indent
        var headRenderCtx = Render.Context.html(state: headState)
        headRenderCtx.render(html.head)
        let headBytes = headState.value.bytes
        if headBytes.starts(with: contentIndent) {
            context.bytes.append(contentsOf: newline)
        }
        context.bytes.append(contentsOf: headBytes)
        headState.value.styles.forEach { key, value in
            context.styles[key] = value
        }

        let styleContentIndent = indent + indent + indent
        let stylesheetBytes = bodyState.value.stylesheetBytes(baseIndentation: styleContentIndent)
        if !bodyState.value.styles.isEmpty {
            context.bytes.append(contentsOf: newline)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: [UInt8].html.tag.styleOpen)
            context.bytes.append(contentsOf: stylesheetBytes)
            context.bytes.append(contentsOf: newline)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: indent)
            context.bytes.append(contentsOf: [UInt8].html.tag.styleClose)
        }

        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.headClose)

        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.bodyOpen)

        if bodyBytes.starts(with: contentIndent) {
            context.bytes.append(contentsOf: newline)
        }
        context.bytes.append(contentsOf: bodyBytes)

        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: indent)
        context.bytes.append(contentsOf: [UInt8].html.tag.bodyClose)

        context.bytes.append(contentsOf: newline)
        context.bytes.append(contentsOf: [UInt8].html.tag.close)
    }
}

extension HTML.__DocumentProtocol {

    @inlinable
    public func asyncDocumentBytes(
        configuration: HTML.Context.Configuration? = nil
    ) async -> [UInt8] {
        await [UInt8](self, configuration: configuration)
    }

    @inlinable
    public func asyncDocumentString(
        configuration: HTML.Context.Configuration? = nil
    ) async -> String {
        await String(self, configuration: configuration)
    }
}
