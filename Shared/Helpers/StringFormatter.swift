//
//  StringFormatter.swift
//  ComputerScienceQuiz
//
//  Created by Efe Yencilek on 2022-03-25.
//

import Foundation
import SwiftUI

// Constant dictionary of replacements
let replacements = [
    "&#039;" : "\u{0027}",
    "&quot;" : "\u{0022}",
    "&lt;": "<",
    "&gt;": ">"
]

extension String {
    func formatKeyCodes() -> String {
        var displaying = self
        
        for replacement in replacements {
            // Replace for each value in the dictionary
            if displaying.contains(replacement.key) {
                displaying = displaying.replacingOccurrences(of: replacement.key, with: replacement.value)
            }
        }
        
        return displaying
    }
}

let darkPurple = Color(hex: "702963")

