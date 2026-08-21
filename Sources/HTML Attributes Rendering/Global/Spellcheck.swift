import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func spellcheck(
        _ attribute: HTML.Spellcheck.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Spellcheck.Attribute.attribute, attribute?.description)
    }
}
