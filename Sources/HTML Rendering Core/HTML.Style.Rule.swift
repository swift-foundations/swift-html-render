import Render_Primitives
public import W3C_CSS_Shared
public import WHATWG_HTML_Shared

extension HTML.Style {

    public struct Rule: Hashable, Sendable {

        public let declaration: String

        public let atRule: HTML.AtRule?

        public let selector: HTML.Selector?

        public let pseudo: HTML.Pseudo?

        public init<P: W3C_CSS_Shared.Property>(
            _ property: P,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.declaration = property.declaration.description
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        public init(
            declaration: String,
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.declaration = declaration
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }
    }
}

extension HTML.Style.Rule {

    public var propertyName: String {
        if let colonIndex = declaration.firstIndex(of: ":") {
            return String(declaration[..<colonIndex])
        }
        return declaration
    }
}

extension HTML.Style.Rule: Equation.`Protocol` {
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.declaration == rhs.declaration
            && lhs.atRule == rhs.atRule
            && lhs.selector == rhs.selector
            && lhs.pseudo == rhs.pseudo
    }
}

extension HTML.Style.Rule: Hash.`Protocol` {
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(declaration)
        hasher.combine(atRule)
        hasher.combine(selector)
        hasher.combine(pseudo)
    }
}
