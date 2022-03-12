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
            Text(question.original.question)
            Text(question.correct ? "Correct" : "Incorrect")
            Text(question.userAnswer)
            if (!question.correct) {
                Text(question.original.correct_answer)
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
