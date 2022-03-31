//
//  QuestionCell.swift
//  ComputerScienceQuiz
//
//

import SwiftUI

struct QuestionCell: View {
    
    var question: AnsweredQuestion
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(question.original.question.formatKeyCodes())
                    .fixedSize(horizontal: false, vertical: true)
                if !question.correct {
                    HStack {
                        Text("Your answer: ")
                        Text(question.userAnswer.formatKeyCodes())
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.red)
                    }
                    .padding(.vertical, 2)
                    HStack {
                        Text("Correct answer: ")
                        Text(question.original.correct_answer.formatKeyCodes())
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.green)
                    }
                } else {
                    Text(question.original.correct_answer.formatKeyCodes())
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.green)
                        .padding(.top, 2)
                }
                
            }
            
            Spacer()
            
            VStack {
                Image(systemName: (question.correct) ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor((question.correct) ? .green : .red)
                    .padding(.top, 10)
                Spacer()
            }
            
        }
        .foregroundColor(.white)
        .font(.headline)
    }
}
