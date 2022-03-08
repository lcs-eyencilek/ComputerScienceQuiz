//
//  Test.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
//

import Foundation

struct Test {
    
    // MARK: Properties
    let testQuestions: [AnsweredQuestion]
    let score: Int
    let completionDate: Date
    
    // MARK: Inizializer
    init (questions: [AnsweredQuestion]) {
        // Assign the Questions
        self.testQuestions = questions
        
        // Determine the score
        var correctAnswerCount = 0
        for i in 0..<questions.count where questions[i].correct {
            correctAnswerCount += 1
        }
        self.score = (correctAnswerCount/questions.count) * 100
        
        // Determine the date
        self.completionDate = Date.now
    }
}
