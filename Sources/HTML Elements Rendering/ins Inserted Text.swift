import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.InsertedText.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .cite(self.cite)
            .dateTime(self.datetime)
    }
}
