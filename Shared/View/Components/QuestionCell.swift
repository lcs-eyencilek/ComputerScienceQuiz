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
        VStack(alignment: .leading) {
            Text(question.original.question.formatKeyCodes())
            Text(question.correct ? "Correct" : "Incorrect")
            Text(question.userAnswer.formatKeyCodes())
            if (!question.correct) {
                Text(question.original.correct_answer.formatKeyCodes())
            }
        }
    }
}

/*
struct QuestionCell_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCell()
    }
}
*/
