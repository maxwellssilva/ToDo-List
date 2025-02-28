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
        switch status {
        case .notStarted:
            status = .inProgress
        case .inProgress:
            status = .completed
        case .completed:
            status = .notStarted
        }
        isCompleted = (status == .completed)
    }

}

enum TaskStatus: String, Codable {
    case notStarted = "Não começou"
    case inProgress = "Em andamento"
    case completed = "Concluído"
}
