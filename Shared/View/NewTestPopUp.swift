//
//  NewTestPopUp.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-09.
//

import SwiftUI

struct NewTestPopUp: View {
    
    //MARK: Properties
    
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
    
    //MARK: Body View
    var body: some View {
        
        HStack {
            
               Spacer()
            
            VStack {
                
                Spacer()
                
                if !progressionComplete {
                    ProgressView("Loading Content")
                        .scaledToFill()
                        .tint(.white)
                        .foregroundColor(.white)
                } else {
                    if questionProvider.questions.isEmpty {
                        // Handle when there's no questions retrieved
                        Image(systemName: "person.fill.questionmark")
                            .resizable()
                            .frame(width: 135, height: 120, alignment: .center)
                            .scaledToFit()
                            .foregroundColor(.white)
                        Text("No questions retrieved, check your connection and try again later.")
                            .font(.title2)
                            .foregroundColor(.white)
                    } else {
                        let current = questionProvider.questions[questionIndex]
                        let answers = questionProvider.returnAllAnswers(at: questionIndex)
                        if questionAnswer.isEmpty {
                            VStack {
                                Text(current.question.formatKeyCodes())
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding(20)
                                ForEach(answers, id: \.self) { answer in
                                    AnswerButton(response: $questionAnswer, color: nil, displayText: answer)
                                }
                            }
                        } else {
                            VStack(alignment: .center) {
                                if questionAnswer == current.correct_answer {
                                    // Put an image for correct response
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60, alignment: .center)
                                        .scaledToFit()
                                        .foregroundColor(.green)
                                    Text("Correct!")
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .fontWeight(.bold)
                                    AnswerButton(response: $questionAnswer, color: .green, displayText: questionAnswer)
                                } else {
                                    // Put an image for wrong response
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60, alignment: .center)
                                        .scaledToFit()
                                        .foregroundColor(.red)
                                    Text("Maybe next time...")
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .fontWeight(.bold)
                                    VStack {
                                        Text("Your answer: ")
                                            .foregroundColor(.white)
                                            .font(.body)
                                        AnswerButton(response: $questionAnswer, color: .red, displayText: questionAnswer)
                                    }
                                    .padding()
                                    
                                    VStack {
                                        Text("Correct answer: ")
                                            .foregroundColor(.white)
                                            .font(.body)
                                        AnswerButton(response: $questionAnswer, color: .green, displayText: current.correct_answer)
                                    }
                                    .padding()
                                }
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
                    .disabled(questionIndex + 1 == questionProvider.questions.count && questionAnswer != "")
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
                            
                            if testRecorder.tests.count == 25 {
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
        .background(
            Image("quiz_bg")
        )
        .interactiveDismissDisabled()
        .edgesIgnoringSafeArea(.all)
    }
}

struct NewTestPopUp_Previews: PreviewProvider {
    static var previews: some View {
        NewTestPopUp(questionProvider: QuestionProviderVM(), testRecorder: TestRecorderVM(), isPresenting: Binding.constant(true))
    }
}
