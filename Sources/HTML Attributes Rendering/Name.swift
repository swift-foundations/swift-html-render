import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func name(
        _ value: HTML.Name.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Name.Attribute.attribute, value?.description)
    }
}

extension HTML.View {

    @discardableResult
    package func name(
        _ value: HTML.Meta.Name.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Meta.Name.Attribute.attribute, value?.description)
    }
}
