//
//  HtmlViewController.swift
//  Telescope
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Cocoa
import WebKit

final class HtmlViewController: NSViewController {

    var webView = TKOWebView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.constrain(subview: webView)
    }


}

final class TKOWebView: WKWebView {

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

extension TKOWebView: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }

        switch navigationAction.navigationType {
        case .linkActivated:
            decisionHandler(.cancel)
            #if os(iOS)
                UIApplication.shared.open(url, options: [:])
            #endif
        default:
            decisionHandler(.allow)
        }
    }
    
}

extension NSView {

    public func constrain(subview: NSView) {
        subview.frame = frame
        subview.translatesAutoresizingMaskIntoConstraints = false
        if !subviews.contains(subview) {
            addSubview(subview)
        }
        topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: subview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: subview.rightAnchor).isActive = true
    }

}
