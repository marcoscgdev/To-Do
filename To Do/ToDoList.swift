//
//  TodoList.swift
//  To Do
//
//  Created by Marcos Calvo Garcia on 13/11/2020.
//

import UIKit

class ToDoList: UITableViewController {
    
    private let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("todolist.items")
    }()
    
    fileprivate var items: [ToDoItem] = []
    
    func add(_ item: ToDoItem) {
        items.append(item)
        
        saveItems()
    }
    
    func loadItems() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "todo_items"),
           let array = try? decoder.decode([ToDoItem].self, from: data) {
            items = array
        }
    }
    
    func saveItems() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "todo_items")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item.title
        
        let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark : .none
        cell.accessoryType = accessory
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < items.count {
            let item = items[indexPath.row]
            item.done = !item.done
            
            saveItems()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveItems()
        }
    }

}
