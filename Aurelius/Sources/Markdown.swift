//
//  Markdown.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation

public struct Markdown: ASTRenderable, HTMLRenderable, XMLRenderable,
    LaTeXRenderable, GroffRenderable, CommonMarkRenderable, AttributedStringRenderable {
    /**
     A string containing CommonMark markdown
     */
    public var markdownString: String

    /**
     Initializes the container with a CommonMark markdown string which can then be rendered depending on protocol conformance

     - parameter markdownString: A string containing CommonMark markdown

     - returns: An instance of Self
     */

    public init(_ markdownString: String) {
        self.markdownString = markdownString
    }
}
