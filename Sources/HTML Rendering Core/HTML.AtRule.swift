import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct AtRule: RawRepresentable, Hashable, Sendable {

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public var rawValue: String
    }
}
