//
//  ContentView.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-03-07.
//

import SwiftUI

struct ContentView: View {
    
    // Observed View Models
    @ObservedObject var questionProvider: QuestionProviderVM
    @ObservedObject var testRecorder: TestRecorderVM
    
    @State var showingNewTest: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(testRecorder.tests) { test in
                        
                    }
                }
            }
            .navigationTitle("Last 50 Tests")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("New Test") {
                        showingNewTest.toggle()
                    }
                }
            }
        }.task {
            await questionProvider.getQuestions()
            print(questionProvider.questions)
            
        }
        .sheet(isPresented: $showingNewTest) {
            NewTestPopUp(questionProvider: questionProvider, testRecorder: testRecorder, togglePopUp: $showingNewTest)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(questionProvider: QuestionProviderVM(), testRecorder: TestRecorderVM())
    }
}
