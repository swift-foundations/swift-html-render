import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML {

    public struct Pseudo: RawRepresentable, Hashable, Sendable, ExpressibleByStringLiteral,
        ExpressibleByStringInterpolation
    {

        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            self.init(rawValue: value)
        }
    }
}

extension HTML.Pseudo {

    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(rawValue: lhs.rawValue + rhs.rawValue)
    }
}

extension HTML.Pseudo {

    public static let after: Self = "::after"

    public static let before: Self = "::before"

    public static let firstLine: Self = "::first-line"
}

extension HTML.Pseudo {

    public static let active: Self = ":active"

    public static let hover: Self = ":hover"

    public static let focus: Self = ":focus"

    public static let visited: Self = ":visited"

    public static let link: Self = ":link"

    public static let checked: Self = ":checked"

    public static let disabled: Self = ":disabled"

    public static let enabled: Self = ":enabled"

    public static let required: Self = ":required"

    public static let optional: Self = ":optional"

    public static let valid: Self = ":valid"

    public static let invalid: Self = ":invalid"

    public static let inRange: Self = ":in-range"

    public static let outOfRange: Self = ":out-of-range"

    public static let readOnly: Self = ":read-only"

    public static let readWrite: Self = ":read-write"

    public static let placeholderShown: Self = ":placeholder-shown"

    public static let firstChild: Self = ":first-child"

    public static let lastChild: Self = ":last-child"

    public static let onlyChild: Self = ":only-child"

    public static let firstOfType: Self = ":first-of-type"

    public static let lastOfType: Self = ":last-of-type"

    public static let onlyOfType: Self = ":only-of-type"

    public static let empty: Self = ":empty"

    public static let root: Self = ":root"

    public static let target: Self = ":target"

    public static let lang: Self = ":lang"

    public static func nthChild(_ n: some CustomStringConvertible) -> Self {
        ":nth-child(\(n))"
    }

    public static func nthLastChild(_ n: some CustomStringConvertible) -> Self {
        ":nth-last-child(\(n))"
    }

    public static func nthOfType(_ n: some CustomStringConvertible) -> Self {
        ":nth-of-type(\(n))"
    }

    public static func nthLastOfType(_ n: some CustomStringConvertible) -> Self {
        ":nth-last-of-type(\(n))"
    }

    public static func `is`(_ s: some CustomStringConvertible) -> Self {
        ":is(\(s))"
    }

    public static func not(_ other: Self) -> Self {
        ":not(\(other.rawValue))"
    }
}
