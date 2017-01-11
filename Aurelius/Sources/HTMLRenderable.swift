//
//  HTMLRenderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public protocol HTMLRenderable: Renderable {
    /**
     Generates an HTML string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering

     - throws: `Errors` depending on the scenario

     - returns: HTML string
     */

    func toHTML(_ options: Options) throws -> String
}

public extension HTMLRenderable {
    /**
     Generates an HTML string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`

     - throws: `Errors` depending on the scenario

     - returns: HTML string
     */

    public func toHTML(_ options: Options = .Default) throws -> String {
        return try markdownString.toHTML(options)
    }
}

public struct HTMLRenderer {
    /**
     Generates an HTML string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: HTML string
     */

    public static func astToHTML(_ ast: UnsafeMutablePointer<cmark_node>, options: Options = .Default) throws -> String {
        guard let cHTMLString = cmark_render_html(ast, options.rawValue) else {
            throw Errors.astRenderingError
        }
        defer { free(cHTMLString) }
        guard let htmlString = String(cString: cHTMLString, encoding: String.Encoding.utf8) else {
            throw Errors.astRenderingError
        }
        return htmlString
    }
}
