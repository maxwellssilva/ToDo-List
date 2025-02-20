//
//  ViewController.swift
//  ToDo-List
//
//  Created by Maxwell Silva on 14/02/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var tasks: [String] = []

    private lazy var taskList: UITableView = {
        let list = UITableView()
        list.dataSource = self
        list.delegate = self
        list.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadTask()
        setupNavigationBar()
        setupLayout()
    }
    
    @objc func didTapAddTask() {
        print("Botão de adicionar pressionado")
        let alert = UIAlertController(title: "New task",
                                      message: "Add new task",
                                      preferredStyle: .alert)
        alert.addTextField {
            textField in textField.placeholder = "Enter your task"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let taskText = alert.textFields?.first?.text, !taskText.isEmpty {
                print("Task added: \(taskText)")
                self.tasks.append(taskText)
                self.saveTask()
                self.taskList.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func saveTask() {
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }

    private func loadTask() {
        tasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
    }

    private func setupNavigationBar() {
        title = "ToDo List 📓"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddTask))
    }

    func setupLayout() {
        view.addSubview(taskList)
        NSLayoutConstraint.activate([
            taskList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            taskList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskList.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
