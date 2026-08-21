import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    public func lang(
        _ language: String
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Lang.Attribute.attribute, language)
    }

    @discardableResult
    public func lang(
        language: String,
        script: String? = nil,
        region: String? = nil
    ) -> HTML._Attributes<Self> {
        self.lang(HTML.Lang.Attribute(language: language, script: script, region: region))
    }

    @discardableResult
    public func lang(
        _ attribute: HTML.Lang.Attribute
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.Lang.Attribute.attribute, attribute.description)
    }
}
