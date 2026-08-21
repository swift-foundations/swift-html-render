public import WHATWG_HTML_Shared

extension HTML.Style.Rule {

    public struct Context: Sendable, Hashable {

        public let atRule: HTML.AtRule?

        public let selector: HTML.Selector?

        public let pseudo: HTML.Pseudo?

        public init(
            atRule: HTML.AtRule? = nil,
            selector: HTML.Selector? = nil,
            pseudo: HTML.Pseudo? = nil
        ) {
            self.atRule = atRule
            self.selector = selector
            self.pseudo = pseudo
        }

        public init(media: HTML.AtRule.Media?) {
            self.atRule = media
            self.selector = nil
            self.pseudo = nil
        }

        public init(pseudo: HTML.Pseudo?) {
            self.atRule = nil
            self.selector = nil
            self.pseudo = pseudo
        }

        public init(selector: HTML.Selector?) {
            self.atRule = nil
            self.selector = selector
            self.pseudo = nil
        }
    }
}

extension HTML.Style.Rule.Context {

    public static let `default` = Self(atRule: nil, selector: nil, pseudo: nil)

    @TaskLocal public static var current: Self = .default
}

extension HTML.Style.Rule.Context {

    public func merging(with other: Self) -> Self {
        Self(
            atRule: other.atRule ?? self.atRule,
            selector: other.selector ?? self.selector,
            pseudo: combinePseudo(self.pseudo, other.pseudo)
        )
    }

    private func combinePseudo(_ lhs: HTML.Pseudo?, _ rhs: HTML.Pseudo?) -> HTML.Pseudo? {
        switch (lhs, rhs) {
        case (nil, nil): return nil
        case (let p?, nil): return p
        case (nil, let p?): return p
        case (let l?, let r?): return l + r
        }
    }
}
