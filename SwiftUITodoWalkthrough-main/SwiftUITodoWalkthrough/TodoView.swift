//
//  TodoView.swift
//  SwiftUITodoWalkthrough
//
//  Created by Brayden Lemke on 10/2/23.
//

import SwiftUI

struct TodoView: View {
    @StateObject var todoController = TodosController()
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Todos")
                        .font(.title)
                        .padding(.leading, 25)
                    Spacer()
                    
                    NavigationLink {
                        CreateToDoView(todosController: todoController)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title.weight(.thin))
                            .padding(.trailing, 25)
                    }
               }
                .padding()
                .frame(height: 40)
                
                List {
                    ForEach($todoController.sections) { $section in
                        Section(section.sectionTitle) {
                            ForEach($section.todos) { $todo in
                                TodoRowView(todo: $todo)
                            }
                            .onDelete(perform: { indexSet in
                                deleteTodo(at: indexSet, from: section)
                            })
                        }
                    }
                }.listStyle(.inset)
            }
            .toolbar(.hidden)
        }
    }
    func deleteTodo(at offsets: IndexSet, from section: TodoSection) {
        if let index = todoController.sections.firstIndex(of: section) {
            todoController.sections[index].todos.remove(atOffsets: offsets)
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
