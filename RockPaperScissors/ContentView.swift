//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Chiraphat Techasiri on 10/2/24.
//

import SwiftUI

struct customBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(
                Color(
                    red: 0,
                    green: 0,
                    blue: 139)
            )
    }
}

struct movesImage: View {
    var gameMove: String
    
    var body: some View {
        Image(gameMove)
            .resizable()
            .frame(width: 80, height: 80, alignment: .center)
            .padding(.bottom, 15)
    }
}

struct ContentView: View {
    private var movesArray = ["Rock", "Paper", "Scissor"]
    
    private var numberOfQuestions = 10
    @State private var questionCounter = 0
    
    @State private var appCurrentChoice = "Rock" // didn't properly initialize
    @State private var userCurrentChoice = ""
    @State private var winOrLose = Bool.random()
    
    @State private var userScore = 0
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .blue]),
                startPoint: .topLeading,
                endPoint: .bottom)
            .ignoresSafeArea()
            
            Spacer()
            
            VStack (spacing: 10) {
                Text("The Brain Game")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                    .padding()
                
                Text("\(questionCounter) out of \(numberOfQuestions)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 100)
                
                VStack {
                    Text("You must \(chooseWinOrLoose())!")
                        .font(.title2.bold())
                        .textCase(.uppercase)
                        .modifier(customBlue())
                        .padding()
                    
                    Text("The Computer Chooses:")
                        .font(.title3.bold())
                        .textCase(.uppercase)
                        .modifier(customBlue())
                        .padding()
                    
                    Button {
                        // make sure to put functionality of button here
                        appCurrentChoice = movesArray[Int.random(in: 0...2)]
                        outComeOftheRound()
                        restartRound()
                    } label: {
                        // the gameMove needed an intilization
                        movesImage(gameMove: appCurrentChoice)
                    }
                    
                    Text("Choose your move:")
                        .font(.title3.bold())
                        .textCase(.uppercase)
                        .modifier(customBlue())
                        .padding()
                    
                    HStack {
                        ForEach(0..<3) { index in
                            Button {
                                userCurrentChoice = movesArray[index]
                                outComeOftheRound()
                                restartRound()
                            } label: {
                                // this needed an array of three
                                movesImage(gameMove: movesArray[index])
                            }
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .opacity(0.9)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("User Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
            }
        }
    }
    
    func chooseWinOrLoose() -> String {
        if winOrLose == true {
            return "Win"
        } else {
            return "Lose"
        }
    }
    
    // didn't write the if condition properly (need to use || and move to next round
    func outComeOftheRound() {
        if winOrLose && appCurrentChoice == "Rock" && userCurrentChoice == "Paper" ||
            winOrLose && appCurrentChoice == "Paper" && userCurrentChoice == "Scissor" ||
            winOrLose && appCurrentChoice == "Scissor" && userCurrentChoice == "Rock" ||
            !winOrLose && appCurrentChoice == "Rock" && userCurrentChoice == "Scissor" || 
            !winOrLose && appCurrentChoice == "Paper" && userCurrentChoice == "Rock" ||
            !winOrLose && appCurrentChoice == "Scissor" && userCurrentChoice == "Paper" {
            userScore += 1
            appCurrentChoice = movesArray[Int.random(in: 0...2)]
            winOrLose = Bool.random()
            questionCounter += 1
        } else {
            appCurrentChoice = movesArray[Int.random(in: 0...2)]
            winOrLose = Bool.random()
            questionCounter += 1
        }
    }
    
    func restartRound() {
        if questionCounter == 11 {
            appCurrentChoice = movesArray[Int.random(in: 0...2)]
            winOrLose = Bool.random()
            questionCounter = 0
            userScore = 0
        }
    }
}

#Preview {
    ContentView()
}
