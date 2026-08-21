import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func httpEquiv(
        _ value: HTML.HttpEquiv.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute("http-equiv", value?.description)
    }
}
