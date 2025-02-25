//
//  ViewController.swift
//  ToDo-List
//
//  Created by Maxwell Silva on 14/02/25.
//

import UIKit

class TodoListViewController: UIViewController {
    
    private var tasks: [Task] = []
    private var filterTasks: [Task] = []
    private var isSearch: Bool = false

    //MARK: - Componentes
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Pesquise por uma atividade"
        searchBar.tintColor = .systemBackground
        searchBar.barTintColor = .systemBackground
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var taskList: UITableView = {
        let list = UITableView()
        list.dataSource = self
        list.delegate = self
        list.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tasks = TaskManager.shared.loadTasks()
        setupNavigationBar()
        setupLayout()
    }
    
    //MARK: - Métodos
    @objc func didTapAddTask() {
        print("Botão de adicionar pressionado")
        showAddTaskAlert()
    }
    
    private func showAddTaskAlert() {
        let alert = UIAlertController(title: "Nova tarefa",
                                      message: "Adicionar nova tarefa",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Digite sua tarefa"
        }
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { _ in
            guard let taskText = alert.textFields?.first?.text, !taskText.isEmpty else {
                self.showErrorMessage()
                return
            }
            
            self.tasks.append(Task(title: taskText, isCompleted: false))
            TaskManager.shared.saveTasks(self.tasks)
            self.taskList.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func showErrorMessage() {
        let errorAlert = UIAlertController(title: "Error", message: "A tarefa não pode estar vazia", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(errorAlert, animated: true)
    }

    private func setupNavigationBar() {
        title = "ToDo List 📓"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddTask))
    }

    func setupLayout() {
        view.addSubview(searchBar)
        view.addSubview(taskList)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            taskList.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            taskList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        searchBar.delegate = self
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? filterTasks.count : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskList.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = isSearch ? filterTasks[indexPath.row] : tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.accessoryType = task.isCompleted ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].toggleCompletion()
        TaskManager.shared.saveTasks(tasks)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            TaskManager.shared.saveTasks(tasks)
            taskList.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TodoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearch = false
            filterTasks = []
        } else {
            isSearch = true
            filterTasks = tasks.filter { tasks in
                return tasks.title.lowercased().contains(searchText.lowercased())
            }
        }
        taskList.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        searchBar.text = ""
        taskList.reloadData()
        searchBar.resignFirstResponder()
    }
}
