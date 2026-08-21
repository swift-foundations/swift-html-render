import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func inputmode(
        _ mode: HTML.Inputmode.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Inputmode.Attribute.attribute, mode?.description)
    }
}
