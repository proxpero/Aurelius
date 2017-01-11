//
//  DocumentsViewController.swift
//  CommonMark
//
//  Created by Todd Olsen on 1/10/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import UIKit

final class DocumentsViewController: UITableViewController {

    var documents: [Document] = []
    var didSelect: (Document) -> () = { _ in }
    var didTapNew: () -> () = {}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(documents[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let episode = documents[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }

    @IBAction func createNewDocument(sender: AnyObject) {
        didTapNew()
    }
    
}
