import Render_Primitives
public import WHATWG_HTML_Shared

extension StringProtocol {

    public init(
        _ html: some HTML.View,
        configuration: HTML.Context.Configuration? = nil
    ) throws(HTML.Context.Configuration.Error) {
        let bytes = ContiguousArray(html, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}

extension StringProtocol {

    @inlinable
    public init<T: HTML.View>(
        _ view: T,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        let bytes = await [UInt8](view, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}

extension StringProtocol {

    public init(
        _ document: some HTML.Document.`Protocol`,
        configuration: HTML.Context.Configuration? = nil
    ) throws(HTML.Context.Configuration.Error) {
        let bytes = ContiguousArray<UInt8>(document, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}

extension StringProtocol {

    @inlinable
    public init<T: HTML.Document.`Protocol`>(
        _ document: T,
        configuration: HTML.Context.Configuration? = nil
    ) async {
        let bytes = await [UInt8](document, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}
