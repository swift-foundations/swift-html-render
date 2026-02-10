//
//  _Tuple+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 25/11/2025.
//

public import Rendering
public import WHATWG_HTML_Shared
public import RenderingAsync

// Extend the _Tuple type from Rendering module to conform to HTML.View
// Note: _Tuple is a top-level type exported from the Rendering module.
// Users can access it as _Tuple<Content...> directly, not through HTML._Tuple.
extension _Tuple: @retroactive Renderable where repeat each Content: HTML.View {
    public typealias Context = HTML.Context
    public typealias Content = Never
    public typealias RenderOutput = UInt8
    public var body: Never { fatalError("body should not be called") }

    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        func render<T: HTML.View>(_ element: T) {
            let oldAttributes = context.attributes
            defer { context.attributes = oldAttributes }
            T._render(element, into: &buffer, context: &context)
        }
        repeat render(each html.content)
    }
}

extension _Tuple: HTML.View where repeat each Content: HTML.View {}

extension _Tuple: @retroactive AsyncRenderable
where repeat each Content: AsyncRenderable, repeat each Content: HTML.View {
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        func render<T: AsyncRenderable>(_ element: T) async where T.Context == HTML.Context {
            let oldAttributes = context.attributes
            defer { context.attributes = oldAttributes }
            await T._renderAsync(element, into: stream, context: &context)
        }
        repeat await render(each html.content)
    }
}
