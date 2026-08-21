import HTML_Snapshot_Test_Support
import Testing

@MainActor
@Suite(
    .serialized,
    .snapshots(configuration: .init(recording: .never))
)
struct `Snapshot Tests` {}
