//
//  Renderable.swift
//  Aurelius
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Foundation

public protocol Renderable {
    /**
     A string containing CommonMark markdown
     */
    var markdownString: String { get set }
}
