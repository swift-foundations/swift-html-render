//
//  AsyncChannel+HTML.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Render_Primitives
public import Async_Primitive
public import Async_Channel_Primitives
import Ownership_Mutable_Primitives
public import WHATWG_HTML_Shared

extension Async_Primitive.Async.Channel<ArraySlice<UInt8>>.Bounded {
    /// Stream HTML with true progressive rendering and backpressure.
    ///
    /// This renders the view synchronously into an HTML.Context, then sends
    /// the bytes in chunks. For true streaming (suspension at element boundaries),
    /// a future async rendering path can be added.
    ///
    /// - Parameters:
    ///   - chunkSize: Size of each yielded chunk in bytes. Default is 4096.
    ///   - configuration: Rendering configuration. Uses default if nil.
    ///   - view: The HTML content to stream.
    public init<View: HTML.View & Sendable>(
        chunkSize: Int = 4096,
        configuration: HTML.Context.Configuration? = nil,
        @HTML.Builder _ view: () -> View
    ) {
        self.init(capacity: Index<ArraySlice<UInt8>>.Count(UInt(1)))
        let view = view()
        let config = configuration ?? .current
        let sender = self.sender
        Task.detached {
            let state = Ownership.Mutable(HTML.Context(config))
            var context = Render.Context.html(state: state)
            context.render(view)
            // Send rendered bytes in chunks
            let allBytes = state.value.bytes
            var offset = 0
            while offset < allBytes.count {
                let end = min(offset + chunkSize, allBytes.count)
                try? await sender.send(ArraySlice(allBytes[offset..<end]))
                offset = end
            }
            sender.close()
        }
    }
}

extension Async_Primitive.Async.Channel<ArraySlice<UInt8>>.Bounded {
    /// Stream an HTML document with true progressive rendering and backpressure.
    ///
    /// - Parameters:
    ///   - chunkSize: Size of each yielded chunk in bytes. Default is 4096.
    ///   - configuration: Rendering configuration. Uses default if nil.
    ///   - document: The HTML document to stream.
    public init<Document: HTML.Document.`Protocol` & Sendable>(
        chunkSize: Int = 4096,
        configuration: HTML.Context.Configuration? = nil,
        @HTML.Builder _ document: () -> Document
    ) {
        self.init(capacity: Index<ArraySlice<UInt8>>.Count(UInt(1)))
        let document = document()
        let config = configuration ?? .current
        let sender = self.sender
        Task.detached {
            var context = HTML.Context(config)
            Document._renderHTMLDocument(document, context: &context)
            let allBytes = context.bytes
            var offset = 0
            while offset < allBytes.count {
                let end = min(offset + chunkSize, allBytes.count)
                try? await sender.send(ArraySlice(allBytes[offset..<end]))
                offset = end
            }
            sender.close()
        }
    }
}
