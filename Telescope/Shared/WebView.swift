//
//  WebView.swift
//  Telescope
//
//  Created by Todd Olsen on 1/10/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import WebKit
import Aurelius

open class WebView: WKWebView {

    /**
     Initializes a web view with the results of rendering a CommonMark Markdown string

     - parameter frame:              The frame size of the web view
     - parameter openLinksInBrowser: Whether or not to open links using an external browser

     - returns: An instance of Self
     */

    public init(frame: CGRect, openLinksInBrowser: Bool = true) {
        super.init(frame: frame, configuration: WKWebViewConfiguration())
        if openLinksInBrowser { navigationDelegate = self }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Properties

    fileprivate let bundle: Bundle = {
        let bundle = Bundle(for: WebView.self)
        let url = bundle.url(forResource: "WebView", withExtension: "bundle")!
        return Bundle(url: url)!
    }()

    fileprivate lazy var baseURL: URL = {
        return self.bundle.url(forResource: "index", withExtension: "html")!
    }()

    public func loadHTMLView(_ markdownString: String) throws {
        let htmlString = try markdownString.toHTML()
        let pageHTMLString = try htmlFromTemplate(htmlString)
        loadHTMLString(pageHTMLString, baseURL: baseURL)
    }

    private func htmlFromTemplate(_ htmlString: String) throws -> String {
        let template = try String(contentsOf: baseURL, encoding: .utf8)
        return template.replacingOccurrences(of: "MY_HTML", with: htmlString)
    }

}

// MARK: - WKNavigationDelegate

extension WebView: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }

        switch navigationAction.navigationType {
        case .linkActivated:
            decisionHandler(.cancel)
            UIApplication.shared.open(url, options: [:])
        default:
            decisionHandler(.allow)
        }
    }
    
}
