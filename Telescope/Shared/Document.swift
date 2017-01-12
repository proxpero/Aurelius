//
//  Document.swift
//  CommonMark
//
//  Created by Todd Olsen on 1/10/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

final class Document {
    var title: String
    var content: String

    init(title: String, content: String = "") {
        self.title = title
        self.content = content
    }
}
