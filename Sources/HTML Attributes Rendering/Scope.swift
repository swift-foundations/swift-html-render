import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func scope(
        _ value: HTML.Scope.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Scope.Attribute.attribute, value?.description)
    }
}
