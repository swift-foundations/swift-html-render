import HTML_Rendering_Core
import HTML_Standard_Attributes
import WHATWG_HTML_TableAttributes

extension HTML.View {

    @discardableResult
    package func span(
        _ value: WHATWG.HTML.Span.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG.HTML.Span.Attribute.attribute, value?.description)
    }
}
