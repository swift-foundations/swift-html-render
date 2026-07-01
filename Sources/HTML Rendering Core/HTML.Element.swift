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

    /// Returns the element type for a given tag name.
    private static func elementType(for tag: String) -> (any WHATWG_HTML.Element.`Protocol`.Type)? {
        switch tag {
        // Document (4.1)
        case "html": return WHATWG_HTML.HtmlRoot.self
        case "head": return WHATWG_HTML.Head.self
        case "body": return WHATWG_HTML.Body.self
        case "title": return WHATWG_HTML.Title.self
        case "base": return WHATWG_HTML.Base.self
        // Metadata (4.2)
        case "meta": return WHATWG_HTML.Meta.self
        case "link": return WHATWG_HTML.Link.self
        case "style": return WHATWG_HTML.Style.self
        // Sections (4.3)
        case "article": return WHATWG_HTML.Article.self
        case "section": return WHATWG_HTML.Section.self
        case "nav": return WHATWG_HTML.NavigationSection.self
        case "aside": return WHATWG_HTML.Aside.self
        case "header": return WHATWG_HTML.Header.self
        case "footer": return WHATWG_HTML.Footer.self
        case "address": return WHATWG_HTML.Address.self
        case "h1": return WHATWG_HTML.H1.self
        case "h2": return WHATWG_HTML.H2.self
        case "h3": return WHATWG_HTML.H3.self
        case "h4": return WHATWG_HTML.H4.self
        case "h5": return WHATWG_HTML.H5.self
        case "h6": return WHATWG_HTML.H6.self
        case "hgroup": return WHATWG_HTML.HeadingGroup.self
        // Grouping Content (4.4)
        case "p": return WHATWG_HTML.Paragraph.self
        case "hr": return WHATWG_HTML.ThematicBreak.self
        case "pre": return WHATWG_HTML.PreformattedText.self
        case "blockquote": return WHATWG_HTML.BlockQuote.self
        case "ol": return WHATWG_HTML.OrderedList.self
        case "ul": return WHATWG_HTML.UnorderedList.self
        case "li": return WHATWG_HTML.ListItem.self
        case "dl": return WHATWG_HTML.DescriptionList.self
        case "dt": return WHATWG_HTML.DescriptionTerm.self
        case "dd": return WHATWG_HTML.DescriptionDetails.self
        case "figure": return WHATWG_HTML.Figure.self
        case "figcaption": return WHATWG_HTML.FigureCaption.self
        case "main": return WHATWG_HTML.Main.self
        case "search": return WHATWG_HTML.Search.self
        case "div": return WHATWG_HTML.ContentDivision.self
        // Text-level Semantics (4.5)
        case "a": return WHATWG_HTML.Anchor.self
        case "em": return WHATWG_HTML.Emphasis.self
        case "strong": return WHATWG_HTML.StrongImportance.self
        case "small": return WHATWG_HTML.Small.self
        case "s": return WHATWG_HTML.Strikethrough.self
        case "cite": return WHATWG_HTML.Cite.self
        case "q": return WHATWG_HTML.InlineQuotation.self
        case "dfn": return WHATWG_HTML.Definition.self
        case "abbr": return WHATWG_HTML.Abbreviation.self
        case "ruby": return WHATWG_HTML.Ruby.self
        case "rb": return WHATWG_HTML.RubyBase.self
        case "rt": return WHATWG_HTML.RubyText.self
        case "rtc": return WHATWG_HTML.RubyTextContainer.self
        case "rp": return WHATWG_HTML.RubyParenthesis.self
        case "data": return WHATWG_HTML.Data.self
        case "time": return WHATWG_HTML.Time.self
        case "code": return WHATWG_HTML.Code.self
        case "var": return WHATWG_HTML.Variable.self
        case "samp": return WHATWG_HTML.Samp.self
        case "kbd": return WHATWG_HTML.KeyboardInput.self
        case "sub": return WHATWG_HTML.Subscript.self
        case "sup": return WHATWG_HTML.Superscript.self
        case "i": return WHATWG_HTML.IdiomaticText.self
        case "b": return WHATWG_HTML.B.self
        case "u": return WHATWG_HTML.UnarticulatedAnnotation.self
        case "bdi": return WHATWG_HTML.BidirectionalIsolate.self
        case "bdo": return WHATWG_HTML.BidirectionalTextOverride.self
        case "span": return WHATWG_HTML.ContentSpan.self
        case "br": return WHATWG_HTML.BR.self
        case "wbr": return WHATWG_HTML.LineBreakOpportunity.self
        case "mark": return WHATWG_HTML.Mark.self
        // Edits (4.7)
        case "ins": return WHATWG_HTML.InsertedText.self
        case "del": return WHATWG_HTML.Del.self
        // Embedded Content (4.8)
        case "picture": return WHATWG_HTML.Picture.self
        case "source": return WHATWG_HTML.Source.self
        case "img": return WHATWG_HTML.Image.self
        case "iframe": return WHATWG_HTML.InlineFrame.self
        case "embed": return WHATWG_HTML.Embed.self
        case "object": return WHATWG_HTML.ExternalObject.self
        case "video": return WHATWG_HTML.Video.self
        case "audio": return WHATWG_HTML.Audio.self
        case "track": return WHATWG_HTML.Track.self
        case "map": return WHATWG_HTML.Map.self
        case "area": return WHATWG_HTML.Area.self
        case "canvas": return WHATWG_HTML.Canvas.self
        case "fencedframe": return WHATWG_HTML.FencedFrame.self
        // Tabular Data (4.9)
        case "table": return WHATWG_HTML.Table.self
        case "caption": return WHATWG_HTML.Caption.self
        case "colgroup": return WHATWG_HTML.TableColumnGroup.self
        case "col": return WHATWG_HTML.TableColumn.self
        case "thead": return WHATWG_HTML.TableHead.self
        case "tbody": return WHATWG_HTML.TableBody.self
        case "tfoot": return WHATWG_HTML.TableFoot.self
        case "tr": return WHATWG_HTML.TableRow.self
        case "th": return WHATWG_HTML.TableHeader.self
        case "td": return WHATWG_HTML.TableDataCell.self
        // Forms (4.10)
        case "form": return WHATWG_HTML.Form.self
        case "label": return WHATWG_HTML.Label.self
        case "input": return WHATWG_HTML.Input.self
        case "button": return WHATWG_HTML.Button.self
        case "select": return WHATWG_HTML.Select.self
        case "datalist": return WHATWG_HTML.DataList.self
        case "optgroup": return WHATWG_HTML.OptionGroup.self
        case "option": return WHATWG_HTML.Option.self
        case "textarea": return WHATWG_HTML.Textarea.self
        case "output": return WHATWG_HTML.Output.self
        case "progress": return WHATWG_HTML.ProgressIndicator.self
        case "meter": return WHATWG_HTML.Meter.self
        case "fieldset": return WHATWG_HTML.FieldSet.self
        case "legend": return WHATWG_HTML.Legend.self
        // Interactive Elements (4.11)
        case "details": return WHATWG_HTML.Details.self
        case "summary": return WHATWG_HTML.DisclosureSummary.self
        case "dialog": return WHATWG_HTML.Dialog.self
        case "menu": return WHATWG_HTML.Menu.self
        // Scripting (4.12)
        case "script": return WHATWG_HTML.Script.self
        case "noscript": return WHATWG_HTML.Noscript.self
        case "template": return WHATWG_HTML.ContentTemplate.self
        case "slot": return WHATWG_HTML.WebComponentSlot.self
        // Obsolete
        case "font": return WHATWG_HTML.Font.self
        case "center": return WHATWG_HTML.Center.self
        case "big": return WHATWG_HTML.Big.self
        case "strike": return WHATWG_HTML.Strike.self
        case "tt": return WHATWG_HTML.TeletypeText.self
        case "marquee": return WHATWG_HTML.Marquee.self
        case "frameset": return WHATWG_HTML.Frameset.self
        case "frame": return WHATWG_HTML.Frame.self
        case "nobr": return WHATWG_HTML.NoBr.self
        case "dir": return WHATWG_HTML.Directory.self
        default: return nil
        }
    }

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
            self.isBlock = !elementType.categories.contains(WHATWG_HTML.Element.Content.Category.phrasing)
            self.isVoid = elementType.content.model == WHATWG_HTML.Element.Content.Model.nothing
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
    public var body: Never { fatalError() }

    /// Renders this HTML element through the `_render` path.
    ///
    /// Uses `pushElement`/`popElement` which the HTML factory overrides for full-fidelity
    /// tag rendering (tag names, void elements, attribute escaping preserved).
    /// Non-HTML contexts get the default implementation that delegates to
    /// `pushBlock`/`pushInline` with no semantic role.
    public static func _render(
        _ view: borrowing Self, context: inout Render.Context
    ) {
        context.open(
            push: .element(
                tagName: view.tagName, isBlock: view.isBlock,
                isVoid: view.isVoid, isPreElement: view.isPreElement
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
