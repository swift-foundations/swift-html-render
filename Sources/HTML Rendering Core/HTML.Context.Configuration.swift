import ASCII
import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML.Context {

    public struct Configuration: Sendable {

        public let forceImportant: Bool

        public let indentation: [UInt8]

        public let newline: [UInt8]

        public let reservedCapacity: Int

        public init(
            forceImportant: Bool,
            indentation: [UInt8],
            newline: [UInt8],
            reservedCapacity: Int
        ) {
            self.forceImportant = forceImportant
            self.indentation = indentation
            self.newline = newline
            self.reservedCapacity = reservedCapacity
        }
    }
}

extension HTML.Context.Configuration {

    public static let `default` = Self(
        forceImportant: false,
        indentation: [],
        newline: [],
        reservedCapacity: 1024
    )

    public static let pretty = Self(
        forceImportant: false,
        indentation: [.ascii.space, .ascii.space],
        newline: [.ascii.lf],
        reservedCapacity: 2048
    )

    public static let email = Self(
        forceImportant: true,
        indentation: [.ascii.space],
        newline: [.ascii.lf],
        reservedCapacity: 2048
    )

    public static let optimized = Self(
        forceImportant: false,
        indentation: [],
        newline: [],
        reservedCapacity: 4096
    )
}

extension HTML.Context.Configuration {

    @TaskLocal public static var current: Self = .default
}

extension HTML.Context.Configuration {

    public struct Error: Swift.Error {

        public let message: String
    }
}
