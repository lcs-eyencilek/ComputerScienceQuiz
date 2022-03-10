//
//  ComputerScienceQuizApp.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-03-07.
//

import SwiftUI

@main
struct ComputerScienceQuizApp: App {
    
    @StateObject private var questionProvider = QuestionProviderVM()
    @StateObject private var testRecorder = TestRecorderVM()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(questionProvider: questionProvider, testRecorder: testRecorder)
            }
        }
    }
}
