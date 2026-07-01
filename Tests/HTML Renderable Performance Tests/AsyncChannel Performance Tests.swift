//
//  AsyncChannel Performance Tests.swift
//  swift-html-rendering
//

import HTML_Snapshot_Test_Support
import Testing

extension `Performance Tests` {
    @Suite
    struct AsyncChannelPerformance {
        @Test(
            .disabled("Performance test - enable manually")
        )
        func largeContentStreaming() async throws {
            let itemCount = 1_000_0000

            struct ListHTML: HTML.View, Sendable {
                let items: [String]

                var body: some HTML.View {
                    tag("ul") {
                        for item in items {
                            tag("li") {
                                HTML.Text(item)
                            }
                        }
                    }
                }
            }

            print("Creating \(itemCount) items...")
            print("Time1: \(ContinuousClock.now)")
            let items = (0..<itemCount).map { "Item \($0)" }
            print("Created items, starting render...")
            print("Time2: \(ContinuousClock.now)")
            let html = ListHTML(items: items)
            print("Time3: \(ContinuousClock.now)")
            var totalBytes = 0
            var chunkCount = 0
            let startTime = ContinuousClock.now

            // Use backpressure mode for bounded memory
            var channel = Async.Channel<ArraySlice<UInt8>>.Bounded { html }
            for try await chunk in channel.receiver.elements {
                if chunkCount == 0 {
                    print("Time3: \(ContinuousClock.now)")
                }
                totalBytes += chunk.count
                chunkCount += 1

                // Print progress every 1000 chunks
                if chunkCount % 1000 == 0 {
                    print("Progress: \(chunkCount) chunks, \(totalBytes) bytes")
                    print("Time4: \(ContinuousClock.now)")
                }
            }

            let elapsed = ContinuousClock.now - startTime
            print(
                "Completed: \(itemCount) items, \(totalBytes) bytes, \(chunkCount) chunks in \(elapsed)"
            )
            #expect(totalBytes > 0)
        }
    }
}
