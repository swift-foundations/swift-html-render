import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func referrerPolicy(
        _ value: HTML.ReferrerPolicy.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.ReferrerPolicy.Attribute.attribute, value?.description)
    }
}
