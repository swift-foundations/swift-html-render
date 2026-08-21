import HTML_Rendering_Core
import HTML_Standard_Attributes

extension HTML.View {

    @discardableResult
    package func disablePictureInPicture(
        _ value: HTML.DisablePictureInPicture.Attribute?
    ) -> HTML._Attributes<Self> {
        self.attribute(HTML.DisablePictureInPicture.Attribute.attribute, value?.description)
    }
}
