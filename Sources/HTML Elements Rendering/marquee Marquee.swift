import HTML_Attributes_Rendering
import HTML_Standard_Elements

extension HTML.Marquee.Element {
    public func callAsFunction(
        @HTML.Builder _ content: () -> some HTML.View
    ) -> some HTML.View {
        HTML.Tag.Element(for: Self.self) { content() }
            .behavior(self.behavior)

            .attribute("bgcolor", self.bgcolor)
            .direction(self.direction)
            .height(self.height)
            .attribute("hspace", self.hspace)
            .loop(self.loop)
            .attribute("scrollamount", self.scrollamount)
            .attribute("scrolldelay", self.scrolldelay)
            .attribute(boolean: self.truespeed)
            .attribute("vspace", self.vspace)
            .width(self.width)
    }
}
