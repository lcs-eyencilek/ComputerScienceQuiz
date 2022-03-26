//
//  MainView.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-10.
//

import SwiftUI

struct MainView: View {
    // Observed View Models
    @ObservedObject var questionProvider: QuestionProviderVM
    @ObservedObject var testRecorder: TestRecorderVM
    
    @State var showingNewTest: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(testRecorder.tests.reversed()) { test in
                    TestCell(test: test)
                }
            }
        }
        .navigationTitle("Last 25 Tests")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("New Test") {
                    showingNewTest.toggle()
                }
            }
        }
        .sheet(isPresented: $showingNewTest) {
            NavigationView {
                NewTestPopUp(questionProvider: questionProvider, testRecorder: testRecorder, isPresenting: $showingNewTest)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(questionProvider: QuestionProviderVM(), testRecorder: TestRecorderVM())
    }
}
