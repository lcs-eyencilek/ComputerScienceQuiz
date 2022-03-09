//
//  Question.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
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

