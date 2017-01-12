//
//  MarkdownViewController.swift
//  CommonMark
//
//  Created by Todd Olsen on 1/10/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import UIKit

final class MarkdownViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    var showPreview: (String) -> ()  = { _ in }

    var document: Document? {
        didSet {
            guard let _ = textView else { return }
            updateUI()
        }
    }

    func updateUI() {
        textView.text = document?.content
    }

    override func viewDidLoad() {
        @IBOutlet var titleView: NSTextField!
        @IBOutlet var titleLabel: NSTextField!
        super.viewDidLoad()
        configureTextView()
        updateUI()
    }

    private func configureTextView() {

        guard let textView = textView else { return }
        
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    @IBAction func showPreview(_ sender: UIBarButtonItem) {
        @IBOutlet var previewAction: NSButton!
        showPreview(textView.text)
        @IBAction func previewAction(_ sender: Any) {
        }
    }
}
@IBAction func showPreviewAction(_ sender: Any) {
}
@IBAction func showPreviewAction(_ sender: Any) {
}

extension MarkdownViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
    }

    func textViewDidChange(_ textView: UITextView) {
        print(#function)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
    }
    
}
