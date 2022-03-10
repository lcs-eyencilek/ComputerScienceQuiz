//
//  AnsweredQuestions.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
//

import Foundation

struct AnsweredQuestion: Codable, Identifiable {
    // MARK: Properties
    var id: UUID = UUID()
    let original: Question
    let userAnswer: String
    let correct: Bool
    
}

