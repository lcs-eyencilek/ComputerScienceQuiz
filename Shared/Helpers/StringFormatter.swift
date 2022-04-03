//
//  StringFormatter.swift
//  ComputerScienceQuiz
//
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


func formatKeyCodes(text: String) -> String {
    var displaying = text
    
    for replacement in replacements {
        // Replace for each value in the dictionary
        if displaying.contains(replacement.key) {
            displaying = displaying.replacingOccurrences(of: replacement.key, with: replacement.value)
        }
    }
    
    return displaying
}

