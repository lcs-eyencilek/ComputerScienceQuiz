//
//  TestRecorderVM.swift
//  ComputerScienceQuiz (iOS)
//
//  Created by Efe Yencilek on 2022-03-07.
//

import Foundation
import SwiftUI

final class TestRecorderVM: ObservableObject {
    // MARK: Properties
    @Published var tests: [Test] = []
    
    // MARK: Initializer
    init(tests: [Test] = []) {
        // Get a URL that points to the saved JSON data containing our list of tasks
        let filename = getDocumentsDirectory().appendingPathComponent(savedTestsLabel)
        
        // Attempt to load from the JSON in the stored / persisted file
        do {
            // Load the raw data
            let data = try Data(contentsOf: filename)
            
            // What was loaded from the file? (Debug)
            print("Got data from file, contents are:")
            print(String(data: data, encoding: .utf8)!)
            
            // Decode the data into Swift native data structures
            self.tests = try JSONDecoder().decode([Test].self, from: data)

        } catch {
            print(error.localizedDescription)
            print("Could not load data from file, initializing with tasks provided to initializer.")
            self.tests = tests
        }
    }
    
    // MARK: Methods
    func persistTasks() {
        // Get a URL that points to theh saved JSON data containing our list of tasks
        let filename = getDocumentsDirectory().appendingPathComponent(savedTestsLabel)
        
        // Try to encode the data in our people array to JSON
        do {
            // Create an encoder
            let encoder = JSONEncoder()
            
            // Ensure the JSON written to the file is human-readable
            encoder.outputFormatting = .prettyPrinted
            
            // Encode the list of tasks we've collected
            let data = try encoder.encode(self.tests)
            
            // Actually write the JSON file to the docouments directory
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            // See the datat that was written
            print("Saved data to documents directory successfully.")
            print("===")
            //print(String(data: data, encoding: .utf8)!)
            
        } catch {
            
            print(error.localizedDescription)
            print("Unable to write list of tasks to documents directory in app bundle on device.")
        }
    }
}
