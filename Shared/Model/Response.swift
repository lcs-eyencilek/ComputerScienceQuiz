//
//  Response.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
//

import Foundation

struct Response: Decodable {
    let response_code: Int
    let results: [Question]
}
