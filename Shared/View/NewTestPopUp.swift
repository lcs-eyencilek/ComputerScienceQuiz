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
    @State var progressionComplete: Bool = false
    
    var body: some View {
        
        HStack {
            
               Spacer()
            
            VStack {
                
                Spacer()
                
                if !progressionComplete {
                    Text("Loading View...")
                } else {
                    if questionProvider.questions.isEmpty {
                        // Handle when there's no questions retrieved
                        Text("No questions retrieved, click abandon or try again please.")
                    } else {
                        let current = questionProvider.questions[questionIndex]
                        if questionAnswer.isEmpty {
                            let answers = questionProvider.returnAllAnswers(at: questionIndex)
                            Text(current.question)
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(20)
                            ForEach(answers, id: \.self) { answer in
                                AnswerButton(response: $questionAnswer, displayText: answer)
                            }
                        } else {
                            Text(questionAnswer == current.correct_answer ? "Correct!" : "Incorrect...")
                            if (questionAnswer != current.correct_answer) {
                                Text("Your answer: \(questionAnswer)")
                                Text("Correct Answer: \(current.correct_answer)")
                            }
                        }
                    }
                }
                
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abandon Test") {
                        // Reset Questions
                        questionProvider.resetQuestions()
                        // Toggle View
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
                        
                        // Reset the questionAnswer
                        questionAnswer = ""
                        
                        if questionIndex + 1 == questionProvider.questions.count {
                            
                            if testRecorder.tests.count == 50 {
                                testRecorder.tests.remove(at: 0)
                            }
                            // Here you'll save the quiz and toggle isPresenting
                            testRecorder.tests.append(Test(questions: recordedAnswers))
                            // Reset the questions
                            questionProvider.resetQuestions()
                            // Permanently save the list fo tasks
                            testRecorder.persistTasks()
                            // Toggle View
                            isPresenting.toggle()
                            
                        } else {
                            // Increase the index
                            questionIndex += 1
                        }
                    }
                    .disabled(questionAnswer == "")
                }
                
            }
            .task {
                await questionProvider.getQuestions()
                progressionComplete.toggle()
            }
            
            Spacer()
            
        }
        .background(.purple)
        .interactiveDismissDisabled()
        .edgesIgnoringSafeArea(.all)
    }
}

struct NewTestPopUp_Previews: PreviewProvider {
    static var previews: some View {
        NewTestPopUp(questionProvider: QuestionProviderVM(), testRecorder: TestRecorderVM(), isPresenting: Binding.constant(true))
    }
}
