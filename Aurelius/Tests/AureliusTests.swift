//
//  AureliusTests.swift
//  AureliusTests
//
//  Created by Todd Olsen on 1/11/17.
//
//

import XCTest
@testable import Aurelius

class BindingTests: XCTestCase {

    let markdown = Markdown("## [CommonMark](http://commonmark.org)")

    func testASTBindingsWork() {
        let ast = try? markdown.toAST()
        XCTAssertNotNil(ast)
    }

    func testHTMLBindingsWork() {
        let html = try? markdown.toHTML()
        XCTAssertNotNil(html)
        XCTAssertTrue(html == "<h2><a href=\"http://commonmark.org\">CommonMark</a></h2>\n")
    }

    func testXMLBindingsWork() {
        let xml = try? markdown.toXML()
        XCTAssertNotNil(xml)
        XCTAssertTrue(xml == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE document SYSTEM \"CommonMark.dtd\">\n<document xmlns=\"http://commonmark.org/xml/1.0\">\n  <heading level=\"2\">\n    <link destination=\"http://commonmark.org\" title=\"\">\n      <text>CommonMark</text>\n    </link>\n  </heading>\n</document>\n")
    }

    func testGroffBindingsWork() {
        let man = try? markdown.toGroff()
        XCTAssertNotNil(man)
        XCTAssertTrue(man == ".SS\nCommonMark (http://commonmark.org)\n")
    }

    func testLaTeXBindngsWork() {
        let latex = try? markdown.toLaTeX()
        XCTAssertNotNil(latex)
        XCTAssertTrue(latex == "\\subsection{\\href{http://commonmark.org}{CommonMark}}\n")
    }

    func testCommonMarkBindngsWork() {
        let commonMark = try? markdown.toCommonMark()
        XCTAssertNotNil(commonMark)
        XCTAssertTrue(commonMark == "## [CommonMark](http://commonmark.org)\n")
    }
    
}

class NSAttributedStringTests: XCTestCase {

    func testAttributedStringBindingsWork() {
        let attributedString = try? Markdown("## [CommonMark](http://commonmark.org)").toAttributedString()
        XCTAssertNotNil(attributedString)
        XCTAssertTrue(attributedString!.string == "CommonMark\n")
    }

    func testInstantiation() {
        let attributedString = try? NSAttributedString(htmlString: "<html><body><p>Hello, World!</p></body></html>")
        XCTAssertNotNil(attributedString)
        XCTAssertTrue(attributedString!.string == "Hello, World!\n")
    }
    
}

class StringTests: XCTestCase {

    func testStringToHTML() {
        let validMarkdown = "## [CommonMark](http://commonmark.org)"
        let html = try? validMarkdown.toHTML()
        XCTAssertNotNil(html)
        XCTAssertTrue(html == "<h2><a href=\"http://commonmark.org\">CommonMark</a></h2>\n")
    }
    
}
