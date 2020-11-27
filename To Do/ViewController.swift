//
//  ViewController.swift
//  To Do
//
//  Created by Marcos Calvo Garcia on 13/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let toDoList = ToDoList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To Do"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.didTapAddItemButton(_:)))
        
        toDoList.loadItems()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = toDoList
        tableView.delegate = toDoList
    }
    
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem) {
            // Create an alert
            let alert = UIAlertController(
                title: "New item",
                message: "Insert the title of the new item:",
                preferredStyle: .alert)

            // Add a text field to the alert for the new item's title
            alert.addTextField(configurationHandler: nil)

            // Add a "cancel" button to the alert. This one doesn't need a handler
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            // Add a "OK" button to the alert. The handler calls addNewToDoItem()
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                if let title = alert.textFields?[0].text {
                    self.addNewItem(title)
                }
            }))

            // Present the alert to the user
            self.present(alert, animated: true, completion: nil)
        }
    
    @IBAction func addNewItem(_ title: String?) {
        guard let todo = title else { return }
        
        toDoList.add(ToDoItem(todo))
        tableView.reloadData()
    }

}

