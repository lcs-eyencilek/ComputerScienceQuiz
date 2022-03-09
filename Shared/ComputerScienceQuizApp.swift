//
//  ComputerScienceQuizApp.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-03-07.
//

import SwiftUI

@main
struct ComputerScienceQuizApp: App {
    
    @StateObject var questionProvider = QuestionProviderVM()
    @StateObject var testRecorder = TestRecorderVM()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(questionProvider: questionProvider, testRecorder: testRecorder)
            }
        }
    }
}
