public import WHATWG_HTML_Shared

@_spi(DynamicHTML)
@inlinable
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { HTML.Empty() }
) -> HTML.Tag.Element<T> {
    HTML.Tag.Element(tag: tagName, content: content)
}

@_spi(DynamicHTML)
@inlinable
public func tag(_ tagName: String) -> HTML.Tag.Element<HTML.Empty> {
    HTML.Tag.Element(tag: tagName) { HTML.Empty() }
}
