//
//  GroffRenderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public protocol GroffRenderable: Renderable {
    /**
     Generates a groff man string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering
     - parameter width:   The width to break on

     - throws: `Errors` depending on the scenario

     - returns: groff man string
     */

    func toGroff(_ options: Options, width: Int32) throws -> String
}

public extension GroffRenderable {
    /**
     Generates a groff man string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `Errors` depending on the scenario

     - returns: groff man string
     */

    public func toGroff(_ options: Options = .Default, width: Int32 = 0) throws -> String {
        let ast = try ASTRenderer.stringToAST(markdownString, options: options)
        let groff = try GroffRenderer.astToGroff(ast, options: options, width: width)
        cmark_node_free(ast)
        return groff
    }
}

public struct GroffRenderer {
    /**
     Generates a groff man string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: groff man string
     */

    public static func astToGroff(_ ast: UnsafeMutablePointer<cmark_node>,
                                  options: Options = .Default,
                                  width: Int32 = 0) throws -> String {
        guard let cGroffString = cmark_render_man(ast, options.rawValue, width) else {
            throw Errors.astRenderingError
        }
        defer { free(cGroffString) }

        guard let groffString = String(cString: cGroffString, encoding: String.Encoding.utf8) else {
            throw Errors.astRenderingError
        }
        
        return groffString
    }
}
