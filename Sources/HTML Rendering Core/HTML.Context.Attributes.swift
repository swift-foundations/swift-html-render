//
//  HTML.Context.Attributes.swift
//  swift-html-render
//

public import WHATWG_HTML_Shared
public import Dictionary_Primitives
public import Dictionary_Ordered_Primitives
public import Shared_Primitive
public import Hash_Indexed_Primitive
public import Hash_Primitives
public import Column_Primitives
public import Buffer_Linear_Primitive

extension HTML.Context {
    /// The ordered set of attributes applied to the next element: a value-semantic
    /// (copy-on-write) insertion-ordered `String` → `String` map on the
    /// dictionary-primitives `Shared` column (Copyable + Sendable).
    public typealias Attributes = Dictionary<
        Shared<Hash.Entry<String, String>, Hash.Indexed<Column.Heap<Hash.Entry<String, String>>>>
    >.Ordered

    /// The collected styles mapped to their generated class names: a value-semantic
    /// (copy-on-write) insertion-ordered `HTML.Element.Style` → `String` map.
    public typealias Styles = Dictionary<
        Shared<Hash.Entry<HTML.Element.Style, String>, Hash.Indexed<Column.Heap<Hash.Entry<HTML.Element.Style, String>>>>
    >.Ordered
}
