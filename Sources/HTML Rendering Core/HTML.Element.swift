//
//  HTML.Element.swift
//
//
//  Created by Point-Free, Inc
//

import ASCII
public import Render_Primitives
public import WHATWG_HTML_Shared

extension HTML.Element {
    /// Represents an HTML element with a tag, attributes, and optional content.
    ///
    /// `HTML.Element.Tag` is a fundamental building block representing a standard HTML element
    /// with a tag name, attributes, and optional child content.
    ///
    /// In the converged architecture, rendering goes through `_render<C: Render.Context>`.
    /// When `C` is `HTML.Context`, full-fidelity tag rendering is used (tag names, void elements,
    /// attribute escaping preserved). In foreign contexts, content renders through semantic methods
    /// with best-effort role mapping.
    public struct Tag<Content> {
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

extension HTML.Element.Tag where Content: HTML.View {
    // MARK: - Element Type Lookup

    // Heterogeneous type lookup: each tag name below resolves to a distinct
    // concrete WHATWG.HTML.Element conformer selected at runtime by the
    // switch; no single `some ... .Type` can express the union.
    // swiftlint:disable no_any_protocol_existential
    /// Returns the element type for a given tag name.
    private static func elementType(for tag: String) -> (any WHATWG.HTML.Element.`Protocol`.Type)? {
        switch tag {
        // Document (4.1)
        case "html": return WHATWG.HTML.Element.HtmlRoot.self
        case "head": return WHATWG.HTML.Element.Head.self
        case "body": return WHATWG.HTML.Element.Body.self
        case "title": return WHATWG.HTML.Element.Title.self
        case "base": return WHATWG.HTML.Element.Base.self

        // Metadata (4.2)
        case "meta": return WHATWG.HTML.Element.Meta.self
        case "link": return WHATWG.HTML.Element.Link.self
        case "style": return WHATWG.HTML.Element.Style.self

        // Sections (4.3)
        case "article": return WHATWG.HTML.Element.Article.self
        case "section": return WHATWG.HTML.Element.Section.self
        case "nav": return WHATWG.HTML.Element.NavigationSection.self
        case "aside": return WHATWG.HTML.Element.Aside.self
        case "header": return WHATWG.HTML.Element.Header.self
        case "footer": return WHATWG.HTML.Element.Footer.self
        case "address": return WHATWG.HTML.Element.Address.self
        case "h1": return WHATWG.HTML.Element.H1.self
        case "h2": return WHATWG.HTML.Element.H2.self
        case "h3": return WHATWG.HTML.Element.H3.self
        case "h4": return WHATWG.HTML.Element.H4.self
        case "h5": return WHATWG.HTML.Element.H5.self
        case "h6": return WHATWG.HTML.Element.H6.self
        case "hgroup": return WHATWG.HTML.Element.HeadingGroup.self

        // Grouping Content (4.4)
        case "p": return WHATWG.HTML.Element.Paragraph.self
        case "hr": return WHATWG.HTML.Element.ThematicBreak.self
        case "pre": return WHATWG.HTML.Element.PreformattedText.self
        case "blockquote": return WHATWG.HTML.Element.BlockQuote.self
        case "ol": return WHATWG.HTML.Element.OrderedList.self
        case "ul": return WHATWG.HTML.Element.UnorderedList.self
        case "li": return WHATWG.HTML.Element.ListItem.self
        case "dl": return WHATWG.HTML.Element.DescriptionList.self
        case "dt": return WHATWG.HTML.Element.DescriptionTerm.self
        case "dd": return WHATWG.HTML.Element.DescriptionDetails.self
        case "figure": return WHATWG.HTML.Element.Figure.self
        case "figcaption": return WHATWG.HTML.Element.FigureCaption.self
        case "main": return WHATWG.HTML.Element.Main.self
        case "search": return WHATWG.HTML.Element.Search.self
        case "div": return WHATWG.HTML.Element.ContentDivision.self

        // Text-level Semantics (4.5)
        case "a": return WHATWG.HTML.Element.Anchor.self
        case "em": return WHATWG.HTML.Element.Emphasis.self
        case "strong": return WHATWG.HTML.Element.StrongImportance.self
        case "small": return WHATWG.HTML.Element.Small.self
        case "s": return WHATWG.HTML.Element.Strikethrough.self
        case "cite": return WHATWG.HTML.Element.Cite.self
        case "q": return WHATWG.HTML.Element.InlineQuotation.self
        case "dfn": return WHATWG.HTML.Element.Definition.self
        case "abbr": return WHATWG.HTML.Element.Abbreviation.self
        case "ruby": return WHATWG.HTML.Element.Ruby.self
        case "rb": return WHATWG.HTML.Element.RubyBase.self
        case "rt": return WHATWG.HTML.Element.RubyText.self
        case "rtc": return WHATWG.HTML.Element.RubyTextContainer.self
        case "rp": return WHATWG.HTML.Element.RubyParenthesis.self
        case "data": return WHATWG.HTML.Element.Data.self
        case "time": return WHATWG.HTML.Element.Time.self
        case "code": return WHATWG.HTML.Element.Code.self
        case "var": return WHATWG.HTML.Element.Variable.self
        case "samp": return WHATWG.HTML.Element.Samp.self
        case "kbd": return WHATWG.HTML.Element.KeyboardInput.self
        case "sub": return WHATWG.HTML.Element.Subscript.self
        case "sup": return WHATWG.HTML.Element.Superscript.self
        case "i": return WHATWG.HTML.Element.IdiomaticText.self
        case "b": return WHATWG.HTML.Element.B.self
        case "u": return WHATWG.HTML.Element.UnarticulatedAnnotation.self
        case "bdi": return WHATWG.HTML.Element.BidirectionalIsolate.self
        case "bdo": return WHATWG.HTML.Element.BidirectionalTextOverride.self
        case "span": return WHATWG.HTML.Element.ContentSpan.self
        case "br": return WHATWG.HTML.Element.BR.self
        case "wbr": return WHATWG.HTML.Element.LineBreakOpportunity.self
        case "mark": return WHATWG.HTML.Element.Mark.self

        // Edits (4.7)
        case "ins": return WHATWG.HTML.Element.InsertedText.self
        case "del": return WHATWG.HTML.Element.Del.self

        // Embedded Content (4.8)
        case "picture": return WHATWG.HTML.Element.Picture.self
        case "source": return WHATWG.HTML.Element.Source.self
        case "img": return WHATWG.HTML.Element.Image.self
        case "iframe": return WHATWG.HTML.Element.InlineFrame.self
        case "embed": return WHATWG.HTML.Element.Embed.self
        case "object": return WHATWG.HTML.Element.ExternalObject.self
        case "video": return WHATWG.HTML.Element.Video.self
        case "audio": return WHATWG.HTML.Element.Audio.self
        case "track": return WHATWG.HTML.Element.Track.self
        case "map": return WHATWG.HTML.Element.Map.self
        case "area": return WHATWG.HTML.Element.Area.self
        case "canvas": return WHATWG.HTML.Element.Canvas.self
        case "fencedframe": return WHATWG.HTML.Element.FencedFrame.self

        // Tabular Data (4.9)
        case "table": return WHATWG.HTML.Element.Table.self
        case "caption": return WHATWG.HTML.Element.Caption.self
        case "colgroup": return WHATWG.HTML.Element.TableColumnGroup.self
        case "col": return WHATWG.HTML.Element.TableColumn.self
        case "thead": return WHATWG.HTML.Element.TableHead.self
        case "tbody": return WHATWG.HTML.Element.TableBody.self
        case "tfoot": return WHATWG.HTML.Element.TableFoot.self
        case "tr": return WHATWG.HTML.Element.TableRow.self
        case "th": return WHATWG.HTML.Element.TableHeader.self
        case "td": return WHATWG.HTML.Element.TableDataCell.self

        // Forms (4.10)
        case "form": return WHATWG.HTML.Element.Form.self
        case "label": return WHATWG.HTML.Element.Label.self
        case "input": return WHATWG.HTML.Element.Input.self
        case "button": return WHATWG.HTML.Element.Button.self
        case "select": return WHATWG.HTML.Element.Select.self
        case "datalist": return WHATWG.HTML.Element.DataList.self
        case "optgroup": return WHATWG.HTML.Element.OptionGroup.self
        case "option": return WHATWG.HTML.Element.Option.self
        case "textarea": return WHATWG.HTML.Element.Textarea.self
        case "output": return WHATWG.HTML.Element.Output.self
        case "progress": return WHATWG.HTML.Element.ProgressIndicator.self
        case "meter": return WHATWG.HTML.Element.Meter.self
        case "fieldset": return WHATWG.HTML.Element.FieldSet.self
        case "legend": return WHATWG.HTML.Element.Legend.self

        // Interactive Elements (4.11)
        case "details": return WHATWG.HTML.Element.Details.self
        case "summary": return WHATWG.HTML.Element.DisclosureSummary.self
        case "dialog": return WHATWG.HTML.Element.Dialog.self
        case "menu": return WHATWG.HTML.Element.Menu.self

        // Scripting (4.12)
        case "script": return WHATWG.HTML.Element.Script.self
        case "noscript": return WHATWG.HTML.Element.Noscript.self
        case "template": return WHATWG.HTML.Element.ContentTemplate.self
        case "slot": return WHATWG.HTML.Element.WebComponentSlot.self

        // Obsolete
        case "font": return WHATWG.HTML.Element.Font.self
        case "center": return WHATWG.HTML.Element.Center.self
        case "big": return WHATWG.HTML.Element.Big.self
        case "strike": return WHATWG.HTML.Element.Strike.self
        case "tt": return WHATWG.HTML.Element.TeletypeText.self
        case "marquee": return WHATWG.HTML.Element.Marquee.self
        case "frameset": return WHATWG.HTML.Element.Frameset.self
        case "frame": return WHATWG.HTML.Element.Frame.self
        case "nobr": return WHATWG.HTML.Element.NoBr.self
        case "dir": return WHATWG.HTML.Element.Directory.self
        default: return nil
        }
    }
    // swiftlint:enable no_any_protocol_existential

    // MARK: - Initializers

    /// Creates a new HTML element with a typed tag.
    public init<Tag: HTML.Element.`Protocol`>(
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
                WHATWG.HTML.Element.Content.Category.phrasing
            )
            self.isVoid = elementType.content.model == WHATWG.HTML.Element.Content.Model.nothing
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

extension HTML.Element.Tag: Render.View where Content: HTML.View {
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

extension HTML.Element.Tag: HTML.View where Content: HTML.View {}

extension HTML.Element.Tag: Sendable where Content: Sendable {}
