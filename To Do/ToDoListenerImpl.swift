//
//  ToDoListenerImpl.swift
//  To Do
//
//  Created by Marcos Calvo Garcia on 13/01/2021.
//

import Foundation

protocol TodoListenerImpl {
    func editItem(_ todoItem: ToDoItem, cellForRowAt indexPath: IndexPath)
}
