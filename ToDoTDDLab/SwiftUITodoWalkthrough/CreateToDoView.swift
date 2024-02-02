//
//  CreateToDoView.swift
//  SwiftUITodoWalkthrough
//
//  Created by Megan Schmoyer on 1/23/24.
//

import SwiftUI

struct CreateToDoView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var todosController: TodosController
    
    @State var newTodoText = ""
    @State var selectedSection: TodoSection
    
    init(todosController: TodosController) {
        _todosController = ObservedObject(wrappedValue: todosController)
        _selectedSection = State(initialValue: todosController.sections[0])
    }
    
    
    var body: some View {
        VStack {
            Text("Create New ToDo")
                .font(.largeTitle)
                .fontWeight(.thin)
                .padding(.top)
            Spacer()
            HStack {
                TextField("Todo", text: $newTodoText)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, style: StrokeStyle(lineWidth: 0.2))
                    )
                    .padding()
                
                
                Picker("For Section", selection: $selectedSection) {
                    ForEach(todosController.sections, id: \.self) { section in
                        Text(section.sectionTitle)
                            .tag(section.sectionTitle)
                    }
                }
                .padding()
             
            }
            

                
                HStack {
                    Spacer()
                    
                        NavigationLink {
                            CreateNewCategory(todosController: todosController)
                        } label: {
                        Text("Add Category")
                            .foregroundColor(.white)
                            .frame(width: 130, height: 35)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.green))
                            
                    }
                    .padding(.vertical, -25)
                        .padding()
                    
                }
                Spacer()
            
            VStack {
                Button {
                    if !newTodoText.isEmpty {
                        addNewToDo(newTodoText, for: selectedSection)
                        dismiss()
                    }
                } label: {
                    Text("Create")
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                }
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(Color.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                            .stroke(.red)
                        )
                    
                }
                
            }
            .padding()
        }
        .toolbar(.hidden)
    }
    func addNewToDo(_ todoTitle: String, for section: TodoSection) {
        
        if let sectionIndex = todosController.sections.firstIndex(where: { $0 == section }) {
            todosController.sections[sectionIndex].todos.append(Todo(markedComplete: false, title: todoTitle))
        }
    }
}

#Preview {
    CreateToDoView(todosController: TodosController())
}
