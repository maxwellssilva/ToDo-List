//
//  ViewController.swift
//  ToDo-List
//
//  Created by Maxwell Silva on 14/02/25.
//

import UIKit

class ViewController: UIViewController {

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
        view.backgroundColor = .white
        setupNavigationBar()
        setupLayout()
    }
    
    @objc func didTapAddTask() {
        print("Botão de adicionar pressionado")
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskList.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel?.text = "Tarefa \(indexPath.row + 1)"
        return cell
    }
}
