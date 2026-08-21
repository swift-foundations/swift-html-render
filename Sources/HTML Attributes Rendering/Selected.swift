import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func selected(
        _ value: HTML.Selected.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
