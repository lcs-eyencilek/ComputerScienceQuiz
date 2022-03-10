//
//  Test.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
//

import Foundation

enum TestCodingKeys: CodingKey {
    case testQuestions
    case score
    case completionDate
}

class Test: Codable, Identifiable, ObservableObject {
    // MARK: Properties
    let testQuestions: [AnsweredQuestion]
    let score: Int
    let completionDate: Date
    
    // MARK: Default Initializer
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
    
    // MARK: Codable Protocols
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TestCodingKeys.self)
        
        self.testQuestions = try container.decode([AnsweredQuestion].self, forKey: .testQuestions)
        self.score = try container.decode(Int.self, forKey: .score)
        self.completionDate = try container.decode(Date.self, forKey: .completionDate)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TestCodingKeys.self)
        
        try container.encode(testQuestions, forKey: .testQuestions)
        try container.encode(score, forKey: .score)
        try container.encode(completionDate, forKey: .completionDate)
    }
}
