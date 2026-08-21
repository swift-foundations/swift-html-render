import Ownership_Mutable_Primitives
import Render_Primitives
public import WHATWG_HTML_Shared

extension RangeReplaceableCollection<UInt8> {

    public init<View: HTML.View>(
        _ view: View,
        configuration: HTML.Context.Configuration? = nil
    ) {
        let state = Ownership.Mutable(HTML.Context(configuration ?? .current))
        var context = Render.Context.html(state: state)
        context.render(view)
        self.init(state.value.bytes)
    }
}

extension RangeReplaceableCollection<UInt8> {

    public init<View: HTML.View>(
        _ view: View,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        let state = Ownership.Mutable(HTML.Context(configuration ?? .current))
        var context = Render.Context.html(state: state)
        context.render(view)
        self.init(state.value.bytes)
    }
}

extension RangeReplaceableCollection<UInt8> {

    @inlinable
    public init<Document: HTML.Document.`Protocol`>(
        _ document: Document,
        configuration: HTML.Context.Configuration? = nil
    ) {
        var context = HTML.Context(configuration ?? .current)
        Document._renderHTMLDocument(document, context: &context)
        self.init(context.bytes)
    }
}

extension RangeReplaceableCollection<UInt8> {

    @inlinable
    public init<Document: HTML.Document.`Protocol`>(
        _ document: Document,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        await Task.yield()
        var context = HTML.Context(configuration ?? .current)
        Document._renderHTMLDocument(document, context: &context)
        self.init(context.bytes)
    }
}
