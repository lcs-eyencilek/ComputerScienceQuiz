//
//  QuestionsList.swift
//  ComputerScienceQuiz
//
//

import SwiftUI

struct QuestionsList: View {
    
    @Binding var isPresenting: Bool
    
    @ObservedObject var test: Test
    
    @State var difficulty: Difficulty = .all
    @State var hideCorrect: Bool = false
    
    var body: some View {
        VStack {
            
            // label for picker
            Text("Difficulty set to...")
                .font(Font.caption.smallCaps())
                .foregroundColor(.secondary)
            
            Picker("Difficulty", selection: $difficulty) {
                Text(Difficulty.all.rawValue.uppercased()).tag(Difficulty.all)
                Text(Difficulty.easy.rawValue.uppercased()).tag(Difficulty.easy)
                Text(Difficulty.medium.rawValue.uppercased()).tag(Difficulty.medium)
                Text(Difficulty.hard.rawValue.uppercased()).tag(Difficulty.hard)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            List {
                ForEach (test.testQuestions) { question in
                    if difficulty == .all {
                        if hideCorrect && !question.correct {
                            QuestionCell(question: question)
                        } else if !hideCorrect {
                            QuestionCell(question: question)
                        }
                    } else if difficulty == question.original.difficulty {
                        if hideCorrect && !question.correct {
                            QuestionCell(question: question)
                        } else if !hideCorrect {
                            QuestionCell(question: question)
                        }
                    }
                }
                .listRowBackground(darkPurple)
                .listRowSeparatorTint(.white)
            }
        }
        .navigationTitle("Score: \(test.score)/100")
        .toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    isPresenting.toggle()
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button("\(hideCorrect ? "Show" : "Hide") Correct") {
                    hideCorrect.toggle()
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
}

struct QuestionsList_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsList(isPresenting: Binding.constant(true), test: Test(questions: []))
    }
}
