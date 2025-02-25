//
//  Model.swift
//  ToDo-List
//
//  Created by Maxwell Silva on 21/02/25.
//

struct Task: Codable {
    let title: String
    var isCompleted: Bool
    var status: TaskStatus
    var targetDate: String
    
    mutating func toggleCompletion() {
        isCompleted.toggle()
        status = isCompleted ? .completed : .inProgress
    }
}

enum TaskStatus: String, Codable {
    case notStarted = "Não começou"
    case inProgress = "Em andamento"
    case completed = "Concluído"
}
