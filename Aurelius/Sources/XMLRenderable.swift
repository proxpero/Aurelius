//
//  XMLRenderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public protocol XMLRenderable: Renderable {
    /**
     Generates an XML string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering

     - throws: `Errors` depending on the scenario

     - returns: XML string
     */

    func toXML(_ options: Options) throws -> String
}

public extension XMLRenderable {
    /**
     Generates an XML string from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`

     - throws: `Errors` depending on the scenario

     - returns: XML string
     */

    public func toXML(_ options: Options = .Default) throws -> String {
        let ast = try ASTRenderer.stringToAST(markdownString, options: options)
        let xml = try XMLRenderer.astToXML(ast, options: options)
        cmark_node_free(ast)
        return xml
    }
}

public struct XMLRenderer {
    /**
     Generates an XML string from the given abstract syntax tree

     **Note:** caller is responsible for calling `cmark_node_free(ast)` after this returns

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`

     - throws: `ASTRenderingError` if the AST could not be converted

     - returns: XML string
     */

    public static func astToXML(_ ast: UnsafeMutablePointer<cmark_node>, options: Options = .Default) throws -> String {
        guard let cXMLString = cmark_render_xml(ast, options.rawValue) else {
            throw Errors.astRenderingError
        }
        defer { free(cXMLString) }

        guard let xmlString = String(cString: cXMLString, encoding: String.Encoding.utf8) else {
            throw Errors.astRenderingError
        }
        
        return xmlString
    }
}
