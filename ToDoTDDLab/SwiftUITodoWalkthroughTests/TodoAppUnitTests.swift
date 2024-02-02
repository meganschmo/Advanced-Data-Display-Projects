//
//  TodoAppUnitTests.swift
//  SwiftUITodoWalkthroughTests
//
//  Created by Megan Schmoyer on 2/1/24.
//

import XCTest
import SwiftUI
@testable import SwiftUITodoWalkthrough

final class TodoAppUnitTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddNewToDo() throws {
        
        let todosController = TodosController()
        let initialTodoCount = todosController.sections.first?.todos.count ?? 0
        let newTodoTitle = "Test Todo"
        
        todosController.addNewToDo(newTodoTitle, for: todosController.sections[0])
        
        XCTAssertEqual(todosController.sections[0].todos.count, initialTodoCount + 1)
        XCTAssertEqual(todosController.sections[0].todos.last?.title, newTodoTitle)
    }
    
    func testAddNewCategory() {
        
        let todosController = TodosController()
        let initialCategoryCount = todosController.sections.count
        let newCategoryTitle = "Test Category"
        
        todosController.addNewCategory(newCategoryTitle)
        
        XCTAssert(true)
        XCTAssertEqual(todosController.sections.count, initialCategoryCount + 1)
        XCTAssertEqual(todosController.sections.last?.sectionTitle, newCategoryTitle)
        XCTAssertEqual(todosController.sections.last?.todos.count, 0)
    }
    
    func testMarkedCompleteProperty() {
 
        var todo = Todo(markedComplete: false, title: "Sample Todo")

        todo.markedComplete = true

        XCTAssertTrue(todo.markedComplete, "Todo should be marked as complete")
    }
    func testDeleteTodo() {
        var todoController = TodosController() // Assuming todoController is initialized and contains some sections and todos
        var sectionToDeleteFrom = todoController.sections.first! // Assuming there is at least one section
        let initialTodosCount = sectionToDeleteFrom.todos.count
        let todoToDelete = sectionToDeleteFrom.todos[0] // Assuming we want to delete the first todo
     
        sectionToDeleteFrom.todos.removeAll(where: { $0.id == todoToDelete.id })
        
        XCTAssertEqual(sectionToDeleteFrom.todos.count, initialTodosCount - 1, "One todo should be deleted")
    }
    func testTodoEquatable() {
   
        let todoID = UUID()
        let todo1 = Todo(id: todoID, markedComplete: false, title: "Todo 1")
        let todo2 = Todo(id: todoID, markedComplete: true, title: "Todo 2")
        let todo3 = Todo(id: UUID(), markedComplete: false, title: "Todo 3")
        
        XCTAssertEqual(todo1, todo2, "Todo instances with the same id should be equal")
        XCTAssertNotEqual(todo1, todo3, "Todo instances with different id should not be equal")
    }
    func testAddNewToDoButton() {
         
         let todosController = TodosController()
         let view = CreateToDoView(todosController: todosController)
        
         view.addNewToDoButtonAction()
         
         XCTAssertEqual(todosController.sections[0].todos.count, 4)
         XCTAssertEqual(todosController.sections[0].todos[0].title, "Homework")
     }

        
        func testCreateButton() {
            // Arrange
            let todosController = TodosController()
            let view = CreateToDoView(todosController: todosController)
            let initialTodoCount = todosController.sections[0].todos.count
            let newTodoTitle = "Test Todo"
            
       
            view.addNewToDoButtonAction()
            
          
            XCTAssertEqual(todosController.sections[0].todos.count, initialTodoCount + 1)
  
        }
 }
    extension CreateToDoView {
        func addNewToDoButtonAction() {
          
            newTodoText = "New Todo"
            addNewToDo(newTodoText, for: selectedSection)
        }
 
    }



