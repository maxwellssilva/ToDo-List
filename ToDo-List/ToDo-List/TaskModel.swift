//
//  Model.swift
//  ToDo-List
//
//  Created by Maxwell Silva on 21/02/25.
//

struct Task: Codable {
    let title: String
    var isCompleted: Bool
    
    mutating func toggleCompletion() {
        isCompleted.toggle()
    }
}
