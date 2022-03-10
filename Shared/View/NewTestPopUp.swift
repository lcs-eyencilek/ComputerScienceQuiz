//
//  NewTestPopUp.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-09.
//

import SwiftUI

struct NewTestPopUp: View {
    
    // Store recorded answers
    @State var recordedAnswers: [AnsweredQuestion] = []
    
    // Observed View Models
    @ObservedObject var questionProvider: QuestionProviderVM
    @ObservedObject var testRecorder: TestRecorderVM
    
    // Toggle View Appearance
    @Binding var isPresenting: Bool
    
    // View Modifiers for Test Progression
    @State var questionIndex: Int = 0
    @State var questionAnswer: String = ""
    
    var body: some View {
        
        VStack {
            if questionProvider.questions.isEmpty {
                Text("Loading View...")
            } else {
                // Temporary constants storing data displayed
                let current = questionProvider.questions[questionIndex]
                let answers = questionProvider.returnAllAnswers(at: questionIndex)
                Text(current.question)
                ForEach(answers, id: \.self) { answer in
                    // You'll pass in questionAnswer and question values
                    AnswerButton()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    isPresenting.toggle()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button(questionIndex + 1 == questionProvider.questions.count ? "Complete" : "Next") {
                    
                    // Create the new answer instance
                    let newAnswer = AnsweredQuestion(
                        original: questionProvider.questions[questionIndex],
                        userAnswer: questionAnswer,
                        correct: questionProvider.questions[questionIndex].correct_answer == questionAnswer)
                    
                    // Save it in the array
                    recordedAnswers.append(newAnswer)
                    
                    if questionIndex + 1 == questionProvider.questions.count {
                        
                        // Here you'll save the quiz and toggle isPresenting
                        testRecorder.tests.append(Test(questions: recordedAnswers))
                        isPresenting.toggle()
                        
                    } else {
                        // Increase the index
                        questionIndex += 1
                    }
                }
            }
        }
        .interactiveDismissDisabled()
        .task {
            await questionProvider.getQuestions()
            // Debug
            print(questionProvider.questions)
        }
    }
}

struct NewTestPopUp_Previews: PreviewProvider {
    static var previews: some View {
        NewTestPopUp(questionProvider: QuestionProviderVM(), testRecorder: TestRecorderVM(), isPresenting: Binding.constant(true))
    }
}
