import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func disableRemotePlayback(
        _ value: HTML.DisableRemotePlayback.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.DisableRemotePlayback.Attribute.attribute, value?.description)
    }
}
