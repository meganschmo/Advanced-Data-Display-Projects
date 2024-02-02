//
//  ContentView.swift
//  SwiftUIAnimationsLab
//
//  Created by Megan Schmoyer on 1/26/24.
//
import SwiftUI

struct ContentView: View {
    @State var opacityNum3 = false
    @State var scaleNum3 = false
    @State var opacityNum2 = false
    @State var scaleNum2 = false
    @State var opacityNum1 = false
    @State var scaleNum1 = false
    @State var animateGo = false
    @State var gameStarted = false

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            Text("GO!")
                .foregroundColor(.white)
                .font(.system(size: 100))
                .opacity(animateGo ? 1 : 0)
                .scaleEffect(animateGo ? 0.2 : 1)

            if gameStarted {
                Text("3")
                    .foregroundColor(.white)
                    .font(.system(size: 100))
                    .opacity(opacityNum3 ? 1 : 0)
                    .scaleEffect(scaleNum3 ? 0.2 : 1)

                Text("2")
                    .foregroundColor(.white)
                    .font(.system(size: 100))
                    .opacity(opacityNum2 ? 1 : 0)
                    .scaleEffect(scaleNum2 ? 0.2 : 1)

                Text("1")
                    .foregroundColor(.white)
                    .font(.system(size: 100))
                    .opacity(opacityNum1 ? 1 : 0)
                    .scaleEffect(scaleNum1 ? 0.2 : 1)
            }

            Spacer()
            VStack {
                Spacer()
                Button(action: {
                    startGame()
                }) {
                    Text("Start Game")
                        .padding()
                }
            }
        }
    }

    func startGame() {
        // Reset animation states
        opacityNum3 = false
        scaleNum3 = false
        opacityNum2 = false
        scaleNum2 = false
        opacityNum1 = false
        scaleNum1 = false
        animateGo = false

        // Start animation sequence
        gameStarted = true

        withAnimation(Animation.easeInOut(duration: 1.0)) {
            opacityNum3 = true
            scaleNum3 = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                opacityNum3 = false
                opacityNum2 = true
                scaleNum2 = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                opacityNum2 = false
                opacityNum1 = true
                scaleNum1 = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                opacityNum1 = false
                animateGo = true
            }
        }
    }
}










//    @State var startingNum = 0
//    @State var displayGo = false
//    @State var numberScale: CGFloat = 1.0
//    @State var goScale: CGFloat = 1.0
//
//    var body: some View {
//        ZStack {
//            Color.black
//                .ignoresSafeArea()
//            
//            VStack {
//                Spacer()
//                if displayGo {
//                    Text("GO!")
//                        .foregroundColor(.white)
//                        .font(.system(size: 100))
//                        .scaleEffect(goScale)
//                } else {
//                    Text("\(startingNum)")
//                        .foregroundColor(.white)
//                        .font(.system(size: 160))
//                        .opacity(startingNum == 0 ? 0.0 : 1.0)
//                        .scaleEffect(numberScale)
//                }
//                Spacer()
//                Button(action: {
//                    startingNum = 3 // Reset starting number
//                    displayGo = false // Reset displayGo
//                    startAnimation()
//                }) {
//                    Text("Start Game")
//                        .padding()
//                }
//            }
//            .padding()
//        }
//    }
//    
//    private func startAnimation() {
//        numberScale = 1.0 // Reset scale for numbers
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            withAnimation(.easeInOut(duration: 1.0)) {
//                numberScale = 0.2 // Scale for numbers
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
//            startingNum -= 1
//            if startingNum > 0 {
//                startAnimation()
//            } else {
//                withAnimation(.easeInOut(duration: 0.5)) {
//                    goScale = 0.2 // Scale for "GO!" text
//                }
//                withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
//                    goScale = 1.0 // Reset scale for "GO!" text
//                }
//                displayGo = true // Show "GO!" text
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//    private func animateGoText() {
//        // Scale down to 0.2
//        withAnimation(.easeInOut(duration: 0.5)) {
//            scale = 0.2
//        }
//
//        // Scale back up to 1.0
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            withAnimation(.easeInOut(duration: 0.5)) {
//                scale = 0.2
//            }
//        }
//    }
