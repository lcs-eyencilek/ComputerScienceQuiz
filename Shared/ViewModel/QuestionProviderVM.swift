//
//  QuestionProviderVM.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
//

import Foundation
import SwiftUI

@MainActor
final class QuestionProviderVM: ObservableObject {
    // MARK: Properties
    // Record new questions here
    @Published private(set) var questions: [Question] = []
    
    // MARK: Default Initializer
    init(questions: [Question] = []) {
        self.questions = questions
    }
    
    // MARK: Fetching Data From API
    // Fetch questions to populate "questions"
    @available(iOS 15.0.0, *)
    func getQuestions() async {
        do {
            questions = try await self.fetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Fetch data from the API
    @available(iOS 15.0.0, *)
    private func fetch() async throws -> [Question] {
        // Create a url session
        let urlSession = URLSession.shared
        // Create your url with appending the route onto the base link
        let url = URL(string: APIConstants.apiUrl)
        let (data, _) = try await urlSession.data(from: url!)
        // Decode the json data in the formate of an array of quotes, the reason why we conformed the quote struct to decodable is to be able to use it here as a decoding format
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        return decoded.results
    }
    
    // MARK: Class Methods
    func returnAllAnswers(at index: Int) -> [String] {
        // You might want to write this code in a do catch block in case the index is out of range
        let question = self.questions[index]
        var answers = question.incorrect_answers
        answers.append(question.correct_answer)
        answers.shuffle()
        return answers
    }
    
    func resetQuestions() {
        self.questions = []
    }
}
