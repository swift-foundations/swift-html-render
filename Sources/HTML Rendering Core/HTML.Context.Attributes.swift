//
//  HTML.Context.Attributes.swift
//  swift-html-render
//

public import Buffer_Linear_Primitive
public import Column_Primitives
public import Dictionary_Ordered_Primitives
public import Dictionary_Primitives
public import Hash_Indexed_Primitive
public import Hash_Primitives
public import Ownership_Shared_Primitive
public import WHATWG_HTML_Shared

extension HTML.Context {
    /// The ordered set of attributes applied to the next element: a value-semantic
    /// (copy-on-write) insertion-ordered `String` → `String` map on the
    /// dictionary-primitives `Shared` column (Copyable + Sendable).
    public typealias Attributes = __DictionaryOrdered<
        Ownership.Shared<
            Hash.Entry<String, String>,
            Hash.Indexed<Column.Heap<Hash.Entry<String, String>>>
        >
    >

    /// The collected styles mapped to their generated class names: a value-semantic
    /// (copy-on-write) insertion-ordered `HTML.Style.Rule` → `String` map.
    public typealias Styles = __DictionaryOrdered<
        Ownership.Shared<
            Hash.Entry<HTML.Style.Rule, String>,
            Hash.Indexed<Column.Heap<Hash.Entry<HTML.Style.Rule, String>>>
        >
    >
}
