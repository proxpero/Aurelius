//
//  LaTeXRenderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public protocol LaTeXRenderable: Renderable {
    /**
     Generates a LaTeX string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering
     - parameter width:   The width to break on

     - throws: `Errors` depending on the scenario

     - returns: LaTeX string
     */

    func toLaTeX(_ options: Options, width: Int32) throws -> String
}

public extension LaTeXRenderable {
    /**
     Generates a LaTeX string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `Errors` depending on the scenario

     - returns: LaTeX string
     */

    public func toLaTeX(_ options: Options = .Default, width: Int32 = 0) throws -> String {
        let ast = try ASTRenderer.stringToAST(markdownString, options: options)
        let latex = try LaTeXRenderer.astToLaTeX(ast, options: options, width: width)
        cmark_node_free(ast)
        return latex
    }
}

public struct LaTeXRenderer {
    /**
     Generates a LaTeX string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`
     - parameter width:   The width to break on, defaulting to 0

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: LaTeX string
     */

    public static func astToLaTeX(_ ast: UnsafeMutablePointer<cmark_node>,
                                  options: Options = .Default,
                                  width: Int32 = 0) throws -> String {
        guard let cLatexString = cmark_render_latex(ast, options.rawValue, width) else {
            throw Errors.astRenderingError
        }
        defer { free(cLatexString) }

        guard let latexString = String(cString: cLatexString, encoding: String.Encoding.utf8) else {
            throw Errors.astRenderingError
        }
        
        return latexString
    }
}
