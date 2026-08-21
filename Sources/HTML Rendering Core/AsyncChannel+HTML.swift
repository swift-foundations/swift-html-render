public import Async_Channel_Primitives
public import Async_Primitive
import Ownership_Mutable_Primitives
import Render_Primitives
public import WHATWG_HTML_Shared

extension Async_Primitive.Async.Channel<ArraySlice<UInt8>>.Bounded {

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

            let allBytes = state.value.bytes
            var offset = 0
            while offset < allBytes.count {
                let end = min(offset + chunkSize, allBytes.count)
                do throws(Async_Primitive.Async.Channel<ArraySlice<UInt8>>.Error) {
                    try await sender.send(ArraySlice(allBytes[offset..<end]))
                } catch {

                }
                offset = end
            }
            sender.close()
        }
    }
}

extension Async_Primitive.Async.Channel<ArraySlice<UInt8>>.Bounded {

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
                do throws(Async_Primitive.Async.Channel<ArraySlice<UInt8>>.Error) {
                    try await sender.send(ArraySlice(allBytes[offset..<end]))
                } catch {

                }
                offset = end
            }
            sender.close()
        }
    }
}
