//
//  HtmlViewController.swift
//  CommonMark
//
//  Created by Todd Olsen on 1/10/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import UIKit

final class HtmlViewController: UIViewController {

    @IBAction func close(_ sender: UIBarButtonItem) {
        didTapClose()
    }

    var webView = WebView(frame: CGRect.zero)
    var didTapClose: () -> () = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.constrain(subview: webView)
//        webView.frame = view.frame
//        view.addSubview(webView)
//        view.topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
//        view.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
//        view.leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
//        view.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
    }
}
