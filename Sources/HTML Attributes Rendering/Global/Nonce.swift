import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func nonce(
        _ attribute: HTML.Nonce.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Nonce.Attribute.attribute, attribute?.description)
    }
}
