//
//  Options.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation
import libcmark

public struct Options: OptionSet {
    public let rawValue: Int32
    public init(rawValue: Int32) { self.rawValue = rawValue }

    /**
     Default options
     */
    public static let Default = Options(rawValue: CMARK_OPT_DEFAULT)

    // MARK: - Rendering Options

    /**
     Include a `data-sourcepos` attribute on all block elements
     */
    public static let SourcePos = Options(rawValue: CMARK_OPT_SOURCEPOS)

    /**
     Render `softbreak` elements as hard line breaks.
     */
    public static let HardBreaks = Options(rawValue: CMARK_OPT_HARDBREAKS)

    /**
     Suppress raw HTML and unsafe links (`javascript:`, `vbscript:`,
     `file:`, and `data:`, except for `image/png`, `image/gif`,
     `image/jpeg`, or `image/webp` mime types).  Raw HTML is replaced
     by a placeholder HTML comment. Unsafe links are replaced by
     empty strings.
     */
    public static let Safe = Options(rawValue: CMARK_OPT_SAFE)

    // MARK: - Parsing Options

    /**
     Normalize tree by consolidating adjacent text nodes.
     */
    public static let Normalize = Options(rawValue: CMARK_OPT_NORMALIZE)

    /**
     Validate UTF-8 in the input before parsing, replacing illegal
     sequences with the replacement character U+FFFD.
     */
    public static let ValidateUTF8 = Options(rawValue: CMARK_OPT_VALIDATE_UTF8)

    /**
     Convert straight quotes to curly, --- to em dashes, -- to en dashes.
     */
    public static let Smart = Options(rawValue: CMARK_OPT_SMART)
    
}
