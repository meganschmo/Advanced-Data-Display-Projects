//
//  TodosController.swift
//  SwiftUITodoWalkthrough
//
//  Created by Megan Schmoyer on 1/23/24.
//

import Foundation

class TodosController: ObservableObject {
    @Published var sections: [TodoSection]
    
    init() {
        sections = TodoSection.dummySections
    }
    func addNewCategory(_ categoryTitle: String) {
        let newCategory = TodoSection(sectionTitle: categoryTitle, todos: [])
        sections.append(newCategory)
    }
    
    func addNewToDo(_ todoTitle: String, for section: TodoSection) {
        if let sectionIndex = sections.firstIndex(where: { $0 == section }) {
            sections[sectionIndex].todos.append(Todo(markedComplete: false, title: todoTitle))
        }
    }
}
