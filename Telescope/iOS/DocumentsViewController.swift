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
    var didCreateNew: (Document) -> () = { _ in }

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

        // Create Alert Controller
        let alertController = UIAlertController(
            title: "Enter Title",
            message: "What is the title of your document?",
            preferredStyle: .alert
        )

        // Add textfield
        alertController.addTextField { textField in
            textField.placeholder = "Things to do"
        }

        // Configure alert action and completion handler.
        let action = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default) { _ in
            guard
                let textFields = alertController.textFields,
                let textField = textFields.first,
                var name = textField.text
                else { return }
            if name.isEmpty {
                name = "New File"
            }

            let document = Document(title: name)
            self.documents.append(document)
            self.tableView.reloadData()
            self.didCreateNew(document)
        }

        alertController.addAction(action)
        self.present(alertController, animated: true)

    }
    
}
