import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func loop(
        _ value: HTML.Loop.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
