//
//  HTML.Element.swift
//
//
//  Created by Point-Free, Inc
//

import ASCII
import OrderedCollections
import Rendering
public import RenderingAsync
public import WHATWG_HTML_Shared

extension HTML.Element {
    /// Represents an HTML element with a tag, attributes, and optional content.
    ///
    /// `HTML.Element.Tag` is a fundamental building block representing a standard HTML element
    /// with a tag name, attributes, and optional child content. This type handles the
    /// rendering of both opening and closing tags, attribute formatting, and proper
    /// indentation based on block vs. inline elements.
    ///
    /// Example using typed initializer:
    /// ```swift
    /// HTML.Element.Tag(for: HTML.Grouping.Div.self) {
    ///     p { "Hello, world!" }
    /// }
    /// ```
    ///
    /// Example using string initializer:
    /// ```swift
    /// HTML.Element.Tag(tag: "div") {
    ///     "Hello, world!"
    /// }
    /// ```
    ///
    /// This type is typically not used directly by library consumers, who would
    /// instead use the more convenient tag functions like `div`, `span`, `p`, etc.
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
    ///
    /// This initializer captures tag metadata at construction time from the
    /// compile-time type, enabling type-safe element creation while storing
    /// the metadata as values for flexible rendering.
    ///
    /// - Parameters:
    ///   - tagType: The WHATWG HTML element type.
    ///   - content: A closure that returns the content of this element.
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
    ///
    /// Uses element type lookup for tag metadata. Prefer the typed initializer
    /// when the tag is known at compile time.
    ///
    /// - Parameters:
    ///   - tag: The HTML tag name.
    ///   - content: A closure that returns the content of this element.
    public init(
        tag: String,
        @HTML.Builder content: () -> Content? = { Never?.none }
    ) {
        self.tagName = tag
        if let elementType = Self.elementType(for: tag) {
            self.isBlock = !elementType.categories.contains(WHATWG_HTML.Element.Content.Category.phrasing)
            self.isVoid = elementType.content.model == WHATWG_HTML.Element.Content.Model.nothing
        } else {
            // Unknown tag - default to block, not void
            self.isBlock = true
            self.isVoid = false
        }
        self.isPreElement = tag == "pre"
        self.content = content()
    }
}

extension HTML.Element.Tag: Rendering.`Protocol`
where Content: Rendering.`Protocol`, Content.Context == HTML.Context, Content.Output == UInt8 {
    public var body: Never {
        fatalError()
    }

    public typealias Content = Never
    public typealias Context = HTML.Context
    public typealias Output = UInt8

    /// Renders this HTML element into the provided buffer.
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ html: Self,
        into buffer: inout Buffer,
        context: inout HTML.Context
    ) where Buffer.Element == UInt8 {
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        let htmlIsBlock = isPrettyPrinting && html.isBlock

        // Add newline and indentation for block elements
        if htmlIsBlock {
            buffer.append(contentsOf: context.configuration.newline)
            buffer.append(contentsOf: context.currentIndentation)
        }

        // Write opening tag
        buffer.append(.ascii.lessThanSign)
        buffer.append(contentsOf: html.tagName.utf8)

        // Add attributes - single-pass escaping without intermediate allocation
        for (name, value) in context.attributes {
            buffer.append(.ascii.space)
            buffer.append(contentsOf: name.utf8)
            if !value.isEmpty {
                buffer.append(.ascii.equalsSign)
                buffer.append(.ascii.dquote)

                // Single-pass: iterate directly over UTF-8 view, escape as needed
                for byte in value.utf8 {
                    switch byte {
                    case .ascii.dquote:
                        buffer.append(contentsOf: [UInt8].html.doubleQuotationMark)
                    case .ascii.apostrophe:
                        buffer.append(contentsOf: [UInt8].html.apostrophe)
                    case .ascii.ampersand:
                        buffer.append(contentsOf: [UInt8].html.ampersand)
                    case .ascii.lessThanSign:
                        buffer.append(contentsOf: [UInt8].html.lessThan)
                    case .ascii.greaterThanSign:
                        buffer.append(contentsOf: [UInt8].html.greaterThan)
                    default:
                        buffer.append(byte)
                    }
                }

                buffer.append(.ascii.dquote)
            }
        }
        buffer.append(.ascii.greaterThanSign)

        // Render content if present
        if let content = html.content {
            let oldAttributes = context.attributes
            let oldIndentation = context.currentIndentation
            defer {
                context.attributes = oldAttributes
                context.currentIndentation = oldIndentation
            }
            context.attributes.removeAll()
            if htmlIsBlock && !html.isPreElement {
                context.currentIndentation += context.configuration.indentation
            }
            Content._render(content, into: &buffer, context: &context)
        }

        // Add closing tag unless it's a void element
        if !html.isVoid {
            if htmlIsBlock && !html.isPreElement {
                buffer.append(contentsOf: context.configuration.newline)
                buffer.append(contentsOf: context.currentIndentation)
            }
            buffer.append(.ascii.lessThanSign)
            buffer.append(.ascii.slant)
            buffer.append(contentsOf: html.tagName.utf8)
            buffer.append(.ascii.greaterThanSign)
        }
    }
}

extension HTML.Element.Tag: HTML.View where Content: HTML.View {}

extension HTML.Element.Tag: Sendable where Content: Sendable {}

// MARK: - Async Rendering

extension HTML.Element.Tag: AsyncRenderable
where Content: AsyncRenderable, Content.Context == HTML.Context {
    /// Async renders this HTML element with backpressure support.
    ///
    /// This implementation mirrors the sync `_render` but uses async writes
    /// to the stream, allowing suspension at strategic points.
    public static func _renderAsync<Stream: Rendering.Async.Sink.`Protocol`>(
        _ html: Self,
        into stream: Stream,
        context: inout HTML.Context
    ) async {
        let isPrettyPrinting = !context.configuration.newline.isEmpty
        let htmlIsBlock = isPrettyPrinting && html.isBlock
        
        // Build opening tag into local buffer, then write once
        var openTag: [UInt8] = []
        
        if htmlIsBlock {
            openTag.append(contentsOf: context.configuration.newline)
            openTag.append(contentsOf: context.currentIndentation)
        }
        
        openTag.append(.ascii.lessThanSign)
        openTag.append(contentsOf: html.tagName.utf8)
        
        // Add attributes
        for (name, value) in context.attributes {
            openTag.append(.ascii.space)
            openTag.append(contentsOf: name.utf8)
            if !value.isEmpty {
                openTag.append(.ascii.equalsSign)
                openTag.append(.ascii.dquote)
                
                for byte in value.utf8 {
                    switch byte {
                    case .ascii.dquote:
                        openTag.append(contentsOf: [UInt8].html.doubleQuotationMark)
                    case .ascii.apostrophe:
                        openTag.append(contentsOf: [UInt8].html.apostrophe)
                    case .ascii.ampersand:
                        openTag.append(contentsOf: [UInt8].html.ampersand)
                    case .ascii.lessThanSign:
                        openTag.append(contentsOf: [UInt8].html.lessThan)
                    case .ascii.greaterThanSign:
                        openTag.append(contentsOf: [UInt8].html.greaterThan)
                    default:
                        openTag.append(byte)
                    }
                }
                
                openTag.append(.ascii.dquote)
            }
        }
        openTag.append(.ascii.greaterThanSign)
        
        await stream.write(openTag)
        
        // Render content if present
        if let content = html.content {
            let oldAttributes = context.attributes
            let oldIndentation = context.currentIndentation
            defer {
                context.attributes = oldAttributes
                context.currentIndentation = oldIndentation
            }
            context.attributes.removeAll()
            if htmlIsBlock && !html.isPreElement {
                context.currentIndentation += context.configuration.indentation
            }
            await Content._renderAsync(content, into: stream, context: &context)
        }
        
        // Add closing tag unless it's a void element
        if !html.isVoid {
            var closeTag: [UInt8] = []
            if htmlIsBlock && !html.isPreElement {
                closeTag.append(contentsOf: context.configuration.newline)
                closeTag.append(contentsOf: context.currentIndentation)
            }
            closeTag.append(.ascii.lessThanSign)
            closeTag.append(.ascii.slant)
            closeTag.append(contentsOf: html.tagName.utf8)
            closeTag.append(.ascii.greaterThanSign)
            
            await stream.write(closeTag)
        }
    }
}
