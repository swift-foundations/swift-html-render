import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func `for`(
        _ value: HTML.For.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.For.Attribute.attribute, value?.description)
    }
}
