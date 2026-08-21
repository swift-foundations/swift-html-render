import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.ThematicBreak.Element: HTML.View {
    public var body: HTML.Tag.Element<HTML.Empty> {
        HTML.Tag.Element(for: Self.self) { HTML.Empty() }
    }
}
