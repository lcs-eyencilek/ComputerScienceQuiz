//
//  TestCell.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-09.
//

import SwiftUI

struct TestCell: View {
    
    @State var test: Test
    @State var presentingQuestions: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(test.completionDate, formatter: formatter)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Score: \(test.score) / 100")
                .font(.title2)
                .foregroundColor(darkPurple)
        }
        .onTapGesture(count: 2) {
            presentingQuestions.toggle()
        }
        .sheet(isPresented: $presentingQuestions) {
            NavigationView {
                QuestionsList(isPresenting: $presentingQuestions, test: test)
            }
        }
    }
}

struct TestCell_Previews: PreviewProvider {
    static var previews: some View {
        TestCell(test: Test(questions: []))
    }
}
