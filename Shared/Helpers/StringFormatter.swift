//
//  StringFormatter.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-25.
//

import Foundation

// Constant library of replacements
let replacements = [
    ["&#039;" : "'"]
]

extension String {
    func formatKeyCodes() -> String {
        var displaying = self
        
        for replacement in replacements {
            // Replace for each value in the library
        }
        
        return displaying
    }
}
