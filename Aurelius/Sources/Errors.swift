//
//  Errors.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation

public enum Errors: Error {
    /**
     Thrown when there was an issue converting the Markdown into an abstract syntax tree
     */
    case markdownToASTError

    /**
     Thrown when the abstract syntax tree could not be rendered into another format
     */
    case astRenderingError

    /**
     Thrown when an HTML string cannot be converted into an `NSData` representation
     */
    case htmlDataConversionError
}
