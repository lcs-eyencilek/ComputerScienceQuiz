//
//  SharedFunctionsAndConstants.swift
//  ComputerScienceQuiz
//
//

import Foundation

// Return the directory that we can save user data it
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

// Define a file label (or file name) that we will write to within that directory
let savedTestsLabel = "savedTests"

// API base URL
enum APIConstants {
    static let apiUrl = "https://opentdb.com/api.php?amount=10&category=18"
}

var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()
