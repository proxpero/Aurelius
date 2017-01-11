//
//  String+HTML.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

extension String {

    /**
     Generates an HTML string from the contents of the string (self), which should contain CommonMark Markdown

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`

     - throws: `Errors` depending on the scenario

     - returns: HTML string
     */
    public func toHTML(_ options: Options = .Default) throws -> String {
        let ast = try ASTRenderer.stringToAST(self, options: options)
        let html = try HTMLRenderer.astToHTML(ast, options: options)
        cmark_node_free(ast)
        return html
    }
    
}
