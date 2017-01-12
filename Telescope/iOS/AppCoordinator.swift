//
//  AppCoordinator.swift
//  CommonMark
//
//  Created by Todd Olsen on 1/10/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import UIKit

let sampleDocuments: [Document] = [
    Document(title: "cmark",
             content: try! String(contentsOf: Bundle.main.url(forResource: "cmark", withExtension: "md")!)),
    Document(title: "CommonMark spec",
             content: try! String(contentsOf: Bundle.main.url(forResource: "CommonMark spec", withExtension: "md")!)),
    Document(title: "maxwell",
             content: try! String(contentsOf: Bundle.main.url(forResource: "maxwell", withExtension: "md")!)),
    Document(title: "ramanujan",
             content: try! String(contentsOf: Bundle.main.url(forResource: "ramanujan", withExtension: "md")!))
]

final class AppCoordinator {

    let storyboard = UIStoryboard.main
    let navigationController: UINavigationController

    init(window: UIWindow) {
        navigationController = window.rootViewController as! UINavigationController
        let documentsVC = navigationController.viewControllers[0] as! DocumentsViewController
        documentsVC.documents = sampleDocuments
        documentsVC.didSelect = showDocument
        documentsVC.didCreateNew = saveNewDocument

    }

    func showDocument(_ document: Document) {
        let markdownVC = storyboard.instantiate(MarkdownViewController.self)
        markdownVC.document = document
        markdownVC.title = document.title

        markdownVC.showPreview = showPreview

        navigationController.pushViewController(markdownVC, animated: true)

    }

    func showPreview(of markdown: String) {
        let previewNC = storyboard.instantiateNavigationController(withIdentifier: "Preview")
        let htmlVC = previewNC.viewControllers[0] as! HtmlViewController
        try! htmlVC.webView.loadHTMLView(markdown)
        htmlVC.didTapClose = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        navigationController.present(previewNC, animated: true, completion: nil)
        
    }
    
    func saveNewDocument(document: Document) {
        
    }
}
