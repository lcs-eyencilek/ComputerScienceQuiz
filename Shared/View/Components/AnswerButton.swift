//
//  AnswerButton.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-10.
//

import SwiftUI

struct AnswerButton: View {
    // Binding response
    @Binding var response: String
    
    let color: Color?
    
    var displayText: String
    
    var body: some View {
        Button {
            response = displayText
        } label: {
            HStack {
                Spacer()
                
                Text(displayText)
                    .foregroundColor(.white)
                    .padding()
                    .font(.headline)
                    .opacity(0.85)
                
                Spacer()
            }
            .background((color != nil) ? color : .indigo)
            .cornerRadius(5)
        }.disabled(color != nil)
        
    }
}
