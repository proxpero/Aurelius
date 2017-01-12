//
//  MarkdownViewController.swift
//  Telescope
//
//  Created by Todd Olsen on 1/11/17.
//
//

import Cocoa

final class MarkdownViewController: NSViewController {

    fileprivate var document: Document?
    fileprivate var htmlViewController: HtmlViewController?

    @IBOutlet var textView: NSTextView!
    @IBOutlet var titleLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        document = Document(title: "cmark",
                 content: try! String(contentsOf: Bundle.main.url(forResource: "cmark", withExtension: "md")!))

        configureTextView()
        updateDocument()
    }

    private func configureTextView() {
        guard let textView = textView else { return }
        textView.delegate = self
        textView.textContainerInset = NSSize(width: 10, height: 10)
    }

    override var representedObject: Any? {
        didSet {
            guard let document = representedObject as? Document else { return }
            self.document = document
            updateDocument()
        }
    }

    func updateDocument() {
        titleLabel.stringValue = document?.title ?? ""
        textView.string = document?.content ?? ""
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard let preview = segue.destinationController as? NSWindowController, let htmlVc = preview.contentViewController as? HtmlViewController else { return }
        if htmlViewController == nil {
            htmlViewController = htmlVc
        }
    }


}

extension MarkdownViewController: NSTextViewDelegate {

    func textDidChange(_ notification: Notification) {
        guard let doc = document else { return }
        doc.content = textView.string ?? ""
        try! htmlViewController?.webView.loadHTMLView(doc.content)
    }

}
