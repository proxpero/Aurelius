//
//  ASTRenderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public protocol ASTRenderable: Renderable {
    /**
     Generates an abstract syntax tree from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering

     - throws: `MarkdownToASTError` if conversion fails

     - returns: An abstract syntax tree representation of the Markdown input
     */

    func toAST(_ options: Options) throws -> UnsafeMutablePointer<cmark_node>
}

public extension ASTRenderable {
    /**
     Generates an abstract syntax tree from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`

     - throws: `MarkdownToASTError` if conversion fails

     - returns: An abstract syntax tree representation of the Markdown input
     */

    public func toAST(_ options: Options = .Default) throws -> UnsafeMutablePointer<cmark_node> {
        return try ASTRenderer.stringToAST(markdownString, options: options)
    }
}

public struct ASTRenderer {
    /**
     Generates an abstract syntax tree from the given CommonMark Markdown string

     **Important:** It is the caller's responsibility to call `cmark_node_free(ast)` on the returned value

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `MarkdownToASTError` if conversion fails

     - returns: An abstract syntax tree representation of the Markdown input
     */

    public static func stringToAST(_ string: String, options: Options = .Default) throws -> UnsafeMutablePointer<cmark_node> {
        var tree: UnsafeMutablePointer<cmark_node>?
        string.withCString {
            let stringLength = Int(strlen($0))
            tree = cmark_parse_document($0, stringLength, options.rawValue)
        }
        guard let ast = tree else {
            throw Errors.markdownToASTError
        }
        return ast
    }
}
