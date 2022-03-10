//
//  NewTestPopUp.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-09.
//

import SwiftUI

struct NewTestPopUp: View {
    
    // Observed View Models
    @ObservedObject var questionProvider: QuestionProviderVM
    @ObservedObject var testRecorder: TestRecorderVM
    
    // Toggle View Appearance
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    isPresenting.toggle()
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

struct NewTestPopUp_Previews: PreviewProvider {
    static var previews: some View {
        NewTestPopUp(questionProvider: QuestionProviderVM(), testRecorder: TestRecorderVM(), isPresenting: Binding.constant(true))
    }
}
