import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func formNovalidate(
        _ value: HTML.FormNovalidate.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
