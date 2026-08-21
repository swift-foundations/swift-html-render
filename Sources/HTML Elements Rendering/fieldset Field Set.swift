import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.FieldSet.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .disabled(self.disabled)
            .form(self.form)
            .name(self.name)
    }
}
