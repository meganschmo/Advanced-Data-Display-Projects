//
//  CreateNewCategory.swift
//  SwiftUITodoWalkthrough
//
//  Created by Megan Schmoyer on 1/24/24.
//

import SwiftUI

struct CreateNewCategory: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var todosController: TodosController
    
    @State var newCategoryText = ""
    
    var body: some View {
        Spacer()
        VStack {
            TextField("New Category", text: $newCategoryText)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, style: StrokeStyle(lineWidth: 0.2))
                )
                .padding()
            
            
            Button {
                // Check if newCategoryText is not empty before adding
                if !newCategoryText.isEmpty {
                    addNewCategory(newCategoryText)
                    dismiss()
                }
            } label: {
                Text("Create New Category")
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
            }
            .padding()
        }
        Spacer()
        }
        
        
    

    
    func addNewCategory(_ categoryTitle: String) {
        let newCategory = TodoSection(sectionTitle: categoryTitle, todos: [])
        todosController.sections.append(newCategory)
    }
}

#Preview {
    CreateNewCategory(todosController: TodosController())
}
