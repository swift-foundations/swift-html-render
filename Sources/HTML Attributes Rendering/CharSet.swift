import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func charset(
        _ value: HTML.CharSet.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute("charset", value?.description)
    }
}
