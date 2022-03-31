//
//  Question.swift
//  ComputerScienceQuiz (iOS)
//
//

import Foundation

struct Question: Codable {
    let category: String
    let type: String
    let difficulty: Difficulty
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

