//
//  ContentView.swift
//  IntroToSwiftUILab
//
//  Created by Megan Schmoyer on 1/18/24.
//

import SwiftUI

struct Sport {
    var golf: String
    var football: String
    var soccer: String
    var baseball: String
}

struct SportButtonView: View {
    let title: String
    @Binding var isButtonPressed: Bool
    var resetButtonStates: () -> Void
    
    var body: some View {
        Button(action: { handleSportButtonPress() }) {
            Text(title)
                .foregroundColor(.white)
                .padding()
                .frame(width: 100, height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.green)
                )
                .opacity(isButtonPressed ? 1.0 : 0.25)
        }
    }
    
    func handleSportButtonPress() {
        resetButtonStates()  // Reset other button states
        isButtonPressed.toggle()
    }
}

struct ContentView: View {
    @State var sport = Sport(golf: "Golf", football: "Football", soccer: "Soccer", baseball: "Baseball")
    @State var submitButtonPressed = false
    
    @State var isGolfButtonPressed = false
    @State var isFootballButtonPressed = false
    @State var isSoccerButtonPressed = false
    @State var isBaseballButtonPressed = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("Favorite Sport")
                    .offset(y: 75)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                Spacer()
                VStack {
                    HStack {
                        SportButtonView(title: "Golf", isButtonPressed: $isGolfButtonPressed, resetButtonStates: resetButtonStates)
                        SportButtonView(title: "Football", isButtonPressed: $isFootballButtonPressed, resetButtonStates: resetButtonStates)
                    }
                    
                    HStack {
                        SportButtonView(title: "Soccer", isButtonPressed: $isSoccerButtonPressed, resetButtonStates: resetButtonStates)
                        SportButtonView(title: "Baseball", isButtonPressed: $isBaseballButtonPressed, resetButtonStates: resetButtonStates)
                    }
                       
                }
                Spacer()
                Button(action: { submitButtonPressed.toggle() }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                        )
                        
                }
                
                Text("You chose \(selectedSportText())!")
                    .foregroundColor(.white)
                    .padding()
                    .opacity(submitButtonPressed ? 1.0 : 0.0)
                
                Spacer()
            }
        }
    }

    func selectedSportText() -> String {
        if isGolfButtonPressed {
            return "Golf"
        } else if isFootballButtonPressed {
            return "Football"
        } else if isSoccerButtonPressed {
            return "Soccer"
        } else if isBaseballButtonPressed {
            return "Baseball"
        } else {
            return "Nothing"
        }
    }
    
    func resetButtonStates() {
        isGolfButtonPressed = false
        isFootballButtonPressed = false
        isSoccerButtonPressed = false
        isBaseballButtonPressed = false
        submitButtonPressed = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
