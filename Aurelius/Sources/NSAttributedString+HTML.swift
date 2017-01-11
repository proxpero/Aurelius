//
//  NSAttributedString+HTML.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//


#if os(OSX)
    import Cocoa
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif

extension NSAttributedString {

    /**
     Instantiates an attributed string with the given HTML string

     - parameter htmlString: An HTML string

     - throws: `HTMLDataConversionError` or an instantiation error

     - returns: An attributed string
     */
    convenience init(htmlString: String) throws {
        guard let data = htmlString.data(using: String.Encoding.utf8) else {
            throw Errors.htmlDataConversionError
        }

        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue)
        ]
        try self.init(data: data, options: options, documentAttributes: nil)
    }
    
}
