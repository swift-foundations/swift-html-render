import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func open(
        _ value: HTML.Open.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
