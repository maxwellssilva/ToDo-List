//
//  TaskManager.swift
//  ToDo-List
//
//  Created by Maxwell Silva on 20/02/25.
//

import Foundation

class TaskManager {
    
    static let shared = TaskManager()
    private let tasksKey = "tasks"
    
    private init() {}
    
    func saveTasks(_ tasks: [Task]) {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: tasksKey)
        } catch {
            print("Erro ao salvar tarefas: \(error)")
        }
    }
    
    func loadTasks() -> [Task] {
        if let data = UserDefaults.standard.data(forKey: tasksKey) {
            do {
                return try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print("Erro ao carregar tarefas: \(error)")
            }
        }
        return []
    }
}
