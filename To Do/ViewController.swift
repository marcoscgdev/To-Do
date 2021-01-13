//
//  ViewController.swift
//  To Do
//
//  Created by Marcos Calvo Garcia on 13/11/2020.
//

import UIKit

class ViewController: UIViewController, TodoListenerImpl {
    
    
    @IBOutlet private var tableView: UITableView!
    
    private let toDoList = ToDoList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "app_name".localized
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.didTapAddItemButton(_:)))
        
        toDoList.loadItems()
        toDoList.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = toDoList
        tableView.delegate = toDoList
    }
    
    @objc private func didTapAddItemButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "new_item_title".localized,
            message: "new_item_description".localized,
            preferredStyle: .alert)

        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "action_cancel".localized, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "action_ok".localized, style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text {
                self.addNewItem(title)
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func editItem(_ todoItem: ToDoItem, cellForRowAt indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "edit_item_title".localized,
            message: "edit_item_description".localized,
            preferredStyle: .alert)

        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "action_cancel".localized, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "action_ok".localized, style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text {
                todoItem.title = title
                self.toDoList.editItem(todoItem, cellForRowAt: indexPath)
                
                self.tableView.reloadData()
            }
        }))

        self.present(alert, animated: true, completion: nil)
        
        alert.textFields?[0].text = todoItem.title
    }
    
    private func addNewItem(_ title: String?) {
        guard let todo = title else { return }
        
        toDoList.add(ToDoItem(todo))
        tableView.reloadData()
    }

}

