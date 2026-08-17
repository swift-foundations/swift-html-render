//
//  HTML.Element.swift
//
//
//  Created by Point-Free, Inc
//

import ASCII
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML.Tag {
    /// Represents an HTML element with a tag, attributes, and optional content.
    ///
    /// `HTML.Tag.Element` is a fundamental building block representing a standard HTML element
    /// with a tag name, attributes, and optional child content.
    ///
    /// In the converged architecture, rendering goes through `_render<C: Render.Context>`.
    /// When `C` is `HTML.Context`, full-fidelity tag rendering is used (tag names, void elements,
    /// attribute escaping preserved). In foreign contexts, content renders through semantic methods
    /// with best-effort role mapping.
    public struct Element<Content> {
        /// The HTML tag name for this element.
        public let tagName: String

        /// Whether this is a block-level element (for pretty-printing).
        public let isBlock: Bool

        /// Whether this is a void element (no closing tag).
        public let isVoid: Bool

        /// Whether this is a pre element (preserves whitespace).
        let isPreElement: Bool

        /// The optional content contained within this element.
        public let content: Content?
    }
}

extension HTML.Tag.Element where Content: HTML.View {
    // MARK: - Element Type Lookup

    // Heterogeneous type lookup: each tag name below resolves to a distinct
    // concrete WHATWG.HTML.Element conformer selected at runtime by the
    // switch; no single `some ... .Type` can express the union.
    // swiftlint:disable no_any_protocol_existential
    /// Returns the element type for a given tag name.
    private static func elementType(for tag: String) -> (any WHATWG.HTML.Type.Element)? {
        switch tag {
        // Document (4.1)
        case "html": return WHATWG.HTML.HtmlRoot.Element.self
        case "head": return WHATWG.HTML.Head.Element.self
        case "body": return WHATWG.HTML.Body.Element.self
        case "title": return WHATWG.HTML.Title.Element.self
        case "base": return WHATWG.HTML.Base.Element.self

        // Metadata (4.2)
        case "meta": return WHATWG.HTML.Meta.Element.self
        case "link": return WHATWG.HTML.Link.Element.self
        case "style": return WHATWG.HTML.Style.Element.self

        // Sections (4.3)
        case "article": return WHATWG.HTML.Article.Element.self
        case "section": return WHATWG.HTML.Section.Element.self
        case "nav": return WHATWG.HTML.NavigationSection.Element.self
        case "aside": return WHATWG.HTML.Aside.Element.self
        case "header": return WHATWG.HTML.Header.Element.self
        case "footer": return WHATWG.HTML.Footer.Element.self
        case "address": return WHATWG.HTML.Address.Element.self
        case "h1": return WHATWG.HTML.H1.Element.self
        case "h2": return WHATWG.HTML.H2.Element.self
        case "h3": return WHATWG.HTML.H3.Element.self
        case "h4": return WHATWG.HTML.H4.Element.self
        case "h5": return WHATWG.HTML.H5.Element.self
        case "h6": return WHATWG.HTML.H6.Element.self
        case "hgroup": return WHATWG.HTML.HeadingGroup.Element.self

        // Grouping Content (4.4)
        case "p": return WHATWG.HTML.Paragraph.Element.self
        case "hr": return WHATWG.HTML.ThematicBreak.Element.self
        case "pre": return WHATWG.HTML.PreformattedText.Element.self
        case "blockquote": return WHATWG.HTML.BlockQuote.Element.self
        case "ol": return WHATWG.HTML.OrderedList.Element.self
        case "ul": return WHATWG.HTML.UnorderedList.Element.self
        case "li": return WHATWG.HTML.ListItem.Element.self
        case "dl": return WHATWG.HTML.DescriptionList.Element.self
        case "dt": return WHATWG.HTML.DescriptionTerm.Element.self
        case "dd": return WHATWG.HTML.DescriptionDetails.Element.self
        case "figure": return WHATWG.HTML.Figure.Element.self
        case "figcaption": return WHATWG.HTML.FigureCaption.Element.self
        case "main": return WHATWG.HTML.Main.Element.self
        case "search": return WHATWG.HTML.Search.Element.self
        case "div": return WHATWG.HTML.ContentDivision.Element.self

        // Text-level Semantics (4.5)
        case "a": return WHATWG.HTML.Anchor.Element.self
        case "em": return WHATWG.HTML.Emphasis.Element.self
        case "strong": return WHATWG.HTML.StrongImportance.Element.self
        case "small": return WHATWG.HTML.Small.Element.self
        case "s": return WHATWG.HTML.Strikethrough.Element.self
        case "cite": return WHATWG.HTML.Cite.Element.self
        case "q": return WHATWG.HTML.InlineQuotation.Element.self
        case "dfn": return WHATWG.HTML.Definition.Element.self
        case "abbr": return WHATWG.HTML.Abbreviation.Element.self
        case "ruby": return WHATWG.HTML.Ruby.Element.self
        case "rb": return WHATWG.HTML.RubyBase.Element.self
        case "rt": return WHATWG.HTML.RubyText.Element.self
        case "rtc": return WHATWG.HTML.RubyTextContainer.Element.self
        case "rp": return WHATWG.HTML.RubyParenthesis.Element.self
        case "data": return WHATWG.HTML.Data.Element.self
        case "time": return WHATWG.HTML.Time.Element.self
        case "code": return WHATWG.HTML.Code.Element.self
        case "var": return WHATWG.HTML.Variable.Element.self
        case "samp": return WHATWG.HTML.Samp.Element.self
        case "kbd": return WHATWG.HTML.KeyboardInput.Element.self
        case "sub": return WHATWG.HTML.Subscript.Element.self
        case "sup": return WHATWG.HTML.Superscript.Element.self
        case "i": return WHATWG.HTML.IdiomaticText.Element.self
        case "b": return WHATWG.HTML.B.Element.self
        case "u": return WHATWG.HTML.UnarticulatedAnnotation.Element.self
        case "bdi": return WHATWG.HTML.BidirectionalIsolate.Element.self
        case "bdo": return WHATWG.HTML.BidirectionalTextOverride.Element.self
        case "span": return WHATWG.HTML.ContentSpan.Element.self
        case "br": return WHATWG.HTML.BR.Element.self
        case "wbr": return WHATWG.HTML.LineBreakOpportunity.Element.self
        case "mark": return WHATWG.HTML.Mark.Element.self

        // Edits (4.7)
        case "ins": return WHATWG.HTML.InsertedText.Element.self
        case "del": return WHATWG.HTML.Del.Element.self

        // Embedded Content (4.8)
        case "picture": return WHATWG.HTML.Picture.Element.self
        case "source": return WHATWG.HTML.Source.Element.self
        case "img": return WHATWG.HTML.Image.Element.self
        case "iframe": return WHATWG.HTML.InlineFrame.Element.self
        case "embed": return WHATWG.HTML.Embed.Element.self
        case "object": return WHATWG.HTML.ExternalObject.Element.self
        case "video": return WHATWG.HTML.Video.Element.self
        case "audio": return WHATWG.HTML.Audio.Element.self
        case "track": return WHATWG.HTML.Track.Element.self
        case "map": return WHATWG.HTML.Map.Element.self
        case "area": return WHATWG.HTML.Area.Element.self
        case "canvas": return WHATWG.HTML.Canvas.Element.self
        case "fencedframe": return WHATWG.HTML.FencedFrame.Element.self

        // Tabular Data (4.9)
        case "table": return WHATWG.HTML.Table.Element.self
        case "caption": return WHATWG.HTML.Caption.Element.self
        case "colgroup": return WHATWG.HTML.TableColumnGroup.Element.self
        case "col": return WHATWG.HTML.TableColumn.Element.self
        case "thead": return WHATWG.HTML.TableHead.Element.self
        case "tbody": return WHATWG.HTML.TableBody.Element.self
        case "tfoot": return WHATWG.HTML.TableFoot.Element.self
        case "tr": return WHATWG.HTML.TableRow.Element.self
        case "th": return WHATWG.HTML.TableHeader.Element.self
        case "td": return WHATWG.HTML.TableDataCell.Element.self

        // Forms (4.10)
        case "form": return WHATWG.HTML.Form.Element.self
        case "label": return WHATWG.HTML.Label.Element.self
        case "input": return WHATWG.HTML.Input.Element.self
        case "button": return WHATWG.HTML.Button.Element.self
        case "select": return WHATWG.HTML.Select.Element.self
        case "datalist": return WHATWG.HTML.DataList.Element.self
        case "optgroup": return WHATWG.HTML.OptionGroup.Element.self
        case "option": return WHATWG.HTML.Option.Element.self
        case "textarea": return WHATWG.HTML.Textarea.Element.self
        case "output": return WHATWG.HTML.Output.Element.self
        case "progress": return WHATWG.HTML.ProgressIndicator.Element.self
        case "meter": return WHATWG.HTML.Meter.Element.self
        case "fieldset": return WHATWG.HTML.FieldSet.Element.self
        case "legend": return WHATWG.HTML.Legend.Element.self

        // Interactive Elements (4.11)
        case "details": return WHATWG.HTML.Details.Element.self
        case "summary": return WHATWG.HTML.DisclosureSummary.Element.self
        case "dialog": return WHATWG.HTML.Dialog.Element.self
        case "menu": return WHATWG.HTML.Menu.Element.self

        // Scripting (4.12)
        case "script": return WHATWG.HTML.Script.Element.self
        case "noscript": return WHATWG.HTML.Noscript.Element.self
        case "template": return WHATWG.HTML.ContentTemplate.Element.self
        case "slot": return WHATWG.HTML.WebComponentSlot.Element.self

        // Obsolete
        case "font": return WHATWG.HTML.Font.Element.self
        case "center": return WHATWG.HTML.Center.Element.self
        case "big": return WHATWG.HTML.Big.Element.self
        case "strike": return WHATWG.HTML.Strike.Element.self
        case "tt": return WHATWG.HTML.TeletypeText.Element.self
        case "marquee": return WHATWG.HTML.Marquee.Element.self
        case "frameset": return WHATWG.HTML.Frameset.Element.self
        case "frame": return WHATWG.HTML.Frame.Element.self
        case "nobr": return WHATWG.HTML.NoBr.Element.self
        case "dir": return WHATWG.HTML.Directory.Element.self
        default: return nil
        }
    }
    // swiftlint:enable no_any_protocol_existential

    // MARK: - Initializers

    /// Creates a new HTML element with a typed tag.
    public init<Tag: HTML.Element>(
        for tagType: Tag.Type,
        @HTML.Builder content: () -> Content? = { Never?.none }
    ) {
        self.tagName = Tag.tag
        self.isBlock = !Tag.categories.contains(.phrasing)
        self.isVoid = Tag.content.model == .nothing
        self.isPreElement = Tag.tag == "pre"
        self.content = content()
    }

    /// Creates a new HTML element with a string tag name.
    public init(
        tag: String,
        @HTML.Builder content: () -> Content? = { Never?.none }
    ) {
        if let elementType = Self.elementType(for: tag) {
            self.isBlock = !elementType.categories.contains(
                WHATWG.HTML.Content.Category.phrasing
            )
            self.isVoid = elementType.content.model == WHATWG.HTML.Content.Model.nothing
        } else {
            self.isBlock = true
            self.isVoid = false
        }
        self.tagName = tag
        self.isPreElement = tag == "pre"
        self.content = content()
    }
}

// MARK: - Render.View conformance

extension HTML.Tag.Element: Render.View where Content: HTML.View {
    public typealias Body = Never
    public var body: Never { fatalError("Body is Never and must not be accessed.") }

    /// Renders this HTML element through the `_render` path.
    ///
    /// Uses `pushElement`/`popElement` which the HTML factory overrides for full-fidelity
    /// tag rendering (tag names, void elements, attribute escaping preserved).
    /// Non-HTML contexts get the default implementation that delegates to
    /// `pushBlock`/`pushInline` with no semantic role.
    public static func _render(
        _ view: borrowing Self,
        context: inout Render.Context
    ) {
        context.open(
            push: .element(
                tagName: view.tagName,
                isBlock: view.isBlock,
                isVoid: view.isVoid,
                isPreElement: view.isPreElement
            ),
            pop: .element(isBlock: view.isBlock)
        )

        if !view.isVoid, let content = view.content {
            Content._render(content, context: &context)
        }
    }
}

extension HTML.Tag.Element: HTML.View where Content: HTML.View {}

extension HTML.Tag.Element: Sendable where Content: Sendable {}
