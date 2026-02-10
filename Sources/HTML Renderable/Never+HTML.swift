//
//  Never+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

/// Conformance of `Never` to `Rendering` to support the type system.
///
/// This provides the `Rendering` conformance with `HTML.Context` as the context type.
/// Each domain module (HTML, XML, etc.) provides its own `Never` conformance.
extension Never: @retroactive Renderable {
    public typealias Content = Never
    public typealias Context = HTML.Context
    public typealias RenderOutput = UInt8

    @inlinable
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ markup: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {}

    public var body: Never { fatalError("body should not be called") }
}

/// Conformance of `Never` to `HTML.View` to support the type system.
///
/// This conformance is provided to allow the use of the `HTML.View` protocol in
/// contexts where no content is expected or possible.
extension Never: HTML.View {}

extension Never: @retroactive AsyncRenderable {
    @inlinable
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ markup: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {}
}
