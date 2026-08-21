import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func noResize(
        _ value: HTML.NoResize.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.NoResize.Attribute.attribute, value?.description)
    }
}
