import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.ExternalObject.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .data(self.data)
            .type(self.type)
            .form(self.form)
            .name(self.name)
            .height(self.height)
            .width(self.width)
            .usemap(self.usemap)
    }
}
