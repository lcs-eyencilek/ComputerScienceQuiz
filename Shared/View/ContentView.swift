//
//  ContentView.swift
//  Shared
//
//  Created by Efe Yencilek on 2022-03-07.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var questionProvider = QuestionProviderVM()
    
    var body: some View {
        ZStack {
            if questionProvider.questions.count > 0 {
                Text(questionProvider.questions.first!.question)
                Text(questionProvider.questions.first!.correct_answer)
            }
        }.task {
            await questionProvider.getQuestions()
            print(questionProvider.questions)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
