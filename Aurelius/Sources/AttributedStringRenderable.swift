//
//  AttributedStringRenderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public protocol AttributedStringRenderable: HTMLRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering

     - throws: `Errors` depending on the scenario

     - returns: An `NSAttributedString`
     */

    func toAttributedString(_ options: Options) throws -> NSAttributedString
}

public extension AttributedStringRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property

     - parameter options: `Options` to modify parsing or rendering, defaulting to `.Default`

     - throws: `Errors` depending on the scenario

     - returns: An `NSAttributedString`
     */

    public func toAttributedString(_ options: Options = .Default) throws -> NSAttributedString {
        let html = try self.toHTML(options)
        return try NSAttributedString(htmlString: html)
    }
}
