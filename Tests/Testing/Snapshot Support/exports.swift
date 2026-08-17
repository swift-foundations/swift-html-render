//
//  exports.swift
//  swift-html-rendering
//

@_exported import HTML_Rendering_Core_Test_Support
@_exported import HTML_Standard_Test_Support
// Swift Testing is deliberately NOT re-exported here. An `@_exported import
// Testing` from a library target leaks the toolchain's `Testing.Test` into
// every module that transitively re-exports this one, making unqualified
// `Test` (Test_Primitives.Test) ambiguous for type lookup fleet-wide.
// Test suites import Testing themselves.
