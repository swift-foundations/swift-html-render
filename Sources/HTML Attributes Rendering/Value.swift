import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func value<Element: CustomStringConvertible>(
        _ value: HTML.Value.Attribute<Element>?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Value.Attribute<Element>.attribute, value?.description)
    }
}
