//
//  AnsweredQuestions.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
//

import Foundation

struct AnsweredQuestion: Codable {
    // MARK: Properties
    let original: Question
    let userAnswer: String
    let correct: Bool
    
}

