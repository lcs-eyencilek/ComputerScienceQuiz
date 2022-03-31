//
//  AnsweredQuestions.swift
//  ComputerScienceQuiz (iOS)
//
//

import Foundation

struct AnsweredQuestion: Codable, Identifiable {
    // MARK: Properties
    var id: UUID = UUID()
    let original: Question
    let userAnswer: String
    let correct: Bool
    
}

