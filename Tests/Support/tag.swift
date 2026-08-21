@_disfavoredOverload
@inlinable
public func tag<T: HTML.View>(
    _ tagName: String,
    @HTML.Builder _ content: () -> T = { HTML.Empty() }
) -> HTML.Tag.Element<T> {
    HTML.Tag.Element(tag: tagName, content: content)
}
