//
//  QuestionCell.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-10.
//

import SwiftUI

struct QuestionCell: View {
    
    var question: AnsweredQuestion
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .leading) {
                
                Spacer()
                
                Text(question.original.question.formatKeyCodes())
                Text(question.original.correct_answer.formatKeyCodes())
                
                Spacer()
            }
            
            Spacer()
        }
        .background(question.correct ? .green : .red)
    }
}

/*
struct QuestionCell_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCell()
    }
}
*/
