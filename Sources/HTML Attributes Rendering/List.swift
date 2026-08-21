import HTML_Rendering_Core
import HTML_Standard_Attributes
private import WHATWG_HTML_FormAttributes

extension HTML.View {

    @discardableResult
    package func list(
        _ value: WHATWG.HTML.List.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(WHATWG.HTML.List.Attribute.attribute, value?.description)
    }
}
