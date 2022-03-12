//
//  ComputerScienceQuizApp.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-03-07.
//

import SwiftUI

@main
struct ComputerScienceQuizApp: App {
    
    // Detect movements between foreground and background
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var questionProvider = QuestionProviderVM()
    @StateObject private var testRecorder = TestRecorderVM()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(questionProvider: questionProvider, testRecorder: testRecorder)
            }
        }
        .onChange(of: scenePhase) { newPhase in
            
            if newPhase == .inactive {
                
                print("Inactive")
                
            } else if newPhase == .active {
                
                print("Active")
                
            } else if newPhase == .background {
                
                print("Background")
                
                // Permanently save the list fo tasks
                testRecorder.persistTasks()
                
            }
            
        }
    }
}
