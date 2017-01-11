//
//  CommonMarkRenderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public protocol CommonMarkRenderable: Renderable {
    /**
     Generates a CommonMark Markdown string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering
     - parameter width:   The width to break on

     - throws: `Errors` depending on the scenario

     - returns: CommonMark Markdown string
     */

    func toCommonMark(_ options: Options, width: Int32) throws -> String
}

public extension CommonMarkRenderable {
    /**
     Generates a CommonMark Markdown string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `Errors` depending on the scenario

     - returns: CommonMark Markdown string
     */

    public func toCommonMark(_ options: Options = .Default, width: Int32 = 0) throws -> String {
        let ast = try ASTRenderer.stringToAST(markdownString, options: options)
        let commonMark = try CommonMarkRenderer.astToCommonMark(ast, options: options, width: width)
        cmark_node_free(ast)
        return commonMark
    }
}

public struct CommonMarkRenderer {
    /**
     Generates a CommonMark Markdown string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: CommonMark Markdown string
     */

    public static func astToCommonMark(_ ast: UnsafeMutablePointer<cmark_node>,
                                       options: Options = .Default,
                                       width: Int32 = 0) throws -> String {
        guard let cCommonMarkString = cmark_render_commonmark(ast, options.rawValue, width) else {
            throw Errors.astRenderingError
        }
        defer { free(cCommonMarkString) }

        guard let commonMarkString = String(cString: cCommonMarkString, encoding: String.Encoding.utf8) else {
            throw Errors.astRenderingError
        }

        return commonMarkString
    }
}
