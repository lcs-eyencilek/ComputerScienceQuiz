//
//  Response.swift
//  ComputerScienceQuiz (iOS)
//
//

import Foundation

struct Response: Decodable {
    let response_code: Int
    let results: [Question]
}
