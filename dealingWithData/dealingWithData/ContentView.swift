//
//  ContentView.swift
//  dealingWithData
//
//  Created by Megan Schmoyer on 1/19/24.
//

import SwiftUI
struct Person {
    var name: String
    var age: String
    var occupation: String
}
struct ContentView: View {
    @State var person = Person(name: "", age: "", occupation: "")
    @State var formSubmitted = false
    var body: some View {
        VStack {
            TextField("Name: ", text: $person.name)
            TextField("Age: ", text: $person.age)
            TextField("Occupation: ", text: $person.occupation)
            Button(action: { formSubmitted = true }) {
                Text("Submit")
                    .padding(.vertical, 8)
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
            
            if formSubmitted {
                Text("\(person.name) is \(person.age) years old. \nOccupation: \(person.occupation)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
