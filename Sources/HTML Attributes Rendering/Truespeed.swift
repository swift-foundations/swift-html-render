import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    package var truespeed: HTML._Attributes<Self> {
        self.attribute(HTML.Truespeed.Attribute.attribute)
    }

    @HTML.Builder
    package func truespeed(
        _ value: HTML.Truespeed.Attribute?
    ) -> some HTML.View {
        self.attribute(boolean: value)
    }
}
