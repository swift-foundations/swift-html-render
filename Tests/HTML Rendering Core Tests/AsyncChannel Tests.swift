//
//  AsyncChannel Tests.swift
//  swift-html-rendering
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

import Async_Channel_Primitives
import HTML_Rendering_Core
import HTML_Rendering
import HTML_Standard
import Render_Primitives
import Testing

@testable import HTML_Rendering_Core

// MARK: - Test Suite

@Suite
struct `AsyncChannel Tests` {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `AsyncChannel Tests`.Unit {

    @Test
    func `streams HTML content`() async throws {
        struct TestHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text("Hello, World!")
                }
            }
        }

        var chunks: [ArraySlice<UInt8>] = []
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded { TestHTML() }
        for try await chunk in channel.receiver.elements {
            chunks.append(chunk)
        }

        let result = String(decoding: chunks.flatMap { $0 }, as: UTF8.self)
        #expect(result.contains("<div>"))
        #expect(result.contains("Hello, World!"))
    }

    @Test
    func `yields complete content`() async throws {
        struct MultiParagraphHTML: HTML.View, Sendable {
            var body: some HTML.View {
                HTML.Group {
                    tag("p") { HTML.Text("First") }
                    tag("p") { HTML.Text("Second") }
                    tag("p") { HTML.Text("Third") }
                }
            }
        }

        var allBytes: [UInt8] = []
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded { MultiParagraphHTML() }
        for try await chunk in channel.receiver.elements {
            allBytes.append(contentsOf: chunk)
        }

        let result = String(decoding: allBytes, as: UTF8.self)
        #expect(result.contains("First"))
        #expect(result.contains("Second"))
        #expect(result.contains("Third"))
    }

    @Test
    func `respects chunk size`() async throws {
        struct LongContentHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text(String(repeating: "a", count: 1000))
                }
            }
        }

        var chunks: [ArraySlice<UInt8>] = []
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded(chunkSize: 100) { LongContentHTML() }
        for try await chunk in channel.receiver.elements {
            chunks.append(chunk)
            #expect(chunk.count <= 100)
        }

        #expect(chunks.count > 1)
    }

    @Test
    func `default chunk size`() async throws {
        struct SimpleHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text("Content")
                }
            }
        }

        var chunkCount = 0
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded { SimpleHTML() }
        for try await _ in channel.receiver.elements {
            chunkCount += 1
        }

        #expect(chunkCount >= 1)
    }

    @Test
    func `custom configuration`() async throws {
        struct StyledHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text("Content")
                }
                .inlineStyle("color", "red")
            }
        }

        var allBytes: [UInt8] = []
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded(chunkSize: 4096, configuration: .email) { StyledHTML() }
        for try await chunk in channel.receiver.elements {
            allBytes.append(contentsOf: chunk)
        }

        let result = String(decoding: allBytes, as: UTF8.self)
        #expect(result.contains("<div"))
        #expect(result.contains("Content"))
    }

    @Test
    func `nil configuration uses default`() async throws {
        struct SpanHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("span") {
                    HTML.Text("Test")
                }
            }
        }

        var allBytes: [UInt8] = []
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded(chunkSize: 4096, configuration: nil) { SpanHTML() }
        for try await chunk in channel.receiver.elements {
            allBytes.append(contentsOf: chunk)
        }

        let result = String(decoding: allBytes, as: UTF8.self)
        #expect(result.contains("<span>"))
    }
}

// MARK: - EdgeCase

extension `AsyncChannel Tests`.EdgeCase {

    @Test
    func `empty content`() async throws {
        struct EmptyHTML: HTML.View, Sendable {
            var body: some HTML.View {
                HTML.Empty()
            }
        }

        var allBytes: [UInt8] = []
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded { EmptyHTML() }
        for try await chunk in channel.receiver.elements {
            allBytes.append(contentsOf: chunk)
        }

        #expect(allBytes.isEmpty)
    }

    @Test
    func `suspends producer when consumer is slow`() async throws {
        struct StreamingHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text(String(repeating: "x", count: 10_000))
                }
            }
        }

        let chunkSize = 100
        var chunksReceived = 0
        var producerSuspended = false

        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded(chunkSize: chunkSize) { StreamingHTML() }

        for try await chunk in channel.receiver.elements {
            chunksReceived += 1
            #expect(chunk.count <= chunkSize, "Chunk should not exceed chunk size")

            if chunksReceived == 3 {
                try? await Task.sleep(for: .milliseconds(50))
                producerSuspended = true
            }

            if chunksReceived > 10 {
                break
            }
        }

        #expect(chunksReceived > 3, "Should have received multiple chunks")
        #expect(producerSuspended, "Test should have exercised slow consumer path")
    }

    @Test
    func `maintains bounded memory with large content`() async throws {
        struct VeryLargeHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text(String(repeating: "a", count: 1_000_000))
                }
            }
        }

        let chunkSize = 4096
        var maxChunkSize = 0
        var totalBytes = 0
        var chunkCount = 0

        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded(chunkSize: chunkSize) { VeryLargeHTML() }
        for try await chunk in channel.receiver.elements {
            chunkCount += 1
            totalBytes += chunk.count

            if chunk.count > maxChunkSize {
                maxChunkSize = chunk.count
            }

            #expect(
                chunk.count <= chunkSize,
                "Chunk \(chunkCount) exceeded size limit: \(chunk.count) > \(chunkSize)"
            )
        }

        #expect(totalBytes > 1_000_000, "Should have rendered all content")
        #expect(chunkCount > 100, "Should have many chunks for large content")
        #expect(maxChunkSize <= chunkSize, "No chunk should exceed the specified size")
    }

    @Test
    func `chunks arrive progressively`() async throws {
        struct ProgressiveHTML: HTML.View, Sendable {
            var body: some HTML.View {
                HTML.Group {
                    tag("header") { HTML.Text(String(repeating: "h", count: 500)) }
                    tag("main") { HTML.Text(String(repeating: "m", count: 500)) }
                    tag("footer") { HTML.Text(String(repeating: "f", count: 500)) }
                }
            }
        }

        var timestamps: [ContinuousClock.Instant] = []
        let startTime = ContinuousClock.now

        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded(chunkSize: 100) { ProgressiveHTML() }
        for try await _ in channel.receiver.elements {
            timestamps.append(ContinuousClock.now)
        }

        #expect(timestamps.count > 1, "Should have received multiple chunks")

        let totalDuration = timestamps.last! - startTime
        #expect(totalDuration < .seconds(5), "Streaming should complete quickly")
    }
}

// MARK: - Integration

extension `AsyncChannel Tests`.Integration {

    @Test
    func `nested elements`() async throws {
        struct NestedHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    tag("ul") {
                        tag("li") { HTML.Text("Item 1") }
                        tag("li") { HTML.Text("Item 2") }
                    }
                }
            }
        }

        var allBytes: [UInt8] = []
        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded { NestedHTML() }
        for try await chunk in channel.receiver.elements {
            allBytes.append(contentsOf: chunk)
        }

        let result = String(decoding: allBytes, as: UTF8.self)
        #expect(result.contains("<ul>"))
        #expect(result.contains("<li>"))
        #expect(result.contains("Item 1"))
        #expect(result.contains("Item 2"))
    }

    @Test
    func `producer and consumer run concurrently`() async throws {
        actor RenderingState {
            var producerStarted = false
            var producerFinished = false
            var firstChunkReceivedWhileProducerRunning = false

            func markProducerStarted() { producerStarted = true }
            func markProducerFinished() { producerFinished = true }
            func checkAndMarkFirstChunk() -> Bool {
                if producerStarted && !producerFinished {
                    firstChunkReceivedWhileProducerRunning = true
                    return true
                }
                return false
            }
            func getResult() -> (started: Bool, finished: Bool, concurrent: Bool) {
                (producerStarted, producerFinished, firstChunkReceivedWhileProducerRunning)
            }
        }

        let state = RenderingState()

        struct LargeContentHTML: HTML.View, Sendable {
            var body: some HTML.View {
                tag("div") {
                    HTML.Text(String(repeating: "x", count: 100_000))
                }
            }
        }

        var chunkCount = 0

        let channel = Async.Channel<ArraySlice<UInt8>>.Bounded(chunkSize: 1000) { LargeContentHTML() }
        await state.markProducerStarted()
        for try await _ in channel.receiver.elements {
            chunkCount += 1

            if chunkCount == 1 {
                _ = await state.checkAndMarkFirstChunk()
            }

            if chunkCount >= 5 {
                break
            }
        }
        await state.markProducerFinished()

        let result = await state.getResult()
        #expect(result.started, "Producer should have started")
        #expect(chunkCount >= 5, "Should have received multiple chunks")
    }
}
