import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func allowfullscreen(
        _ value: HTML.Allowfullscreen.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
