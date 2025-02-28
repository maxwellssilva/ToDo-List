//
//  TaskCell.swift
//  ToDo-List
//
//  Created by Maxwell Silva on 25/02/25.
//

import UIKit

class TaskCell: UITableViewCell {
    
    private lazy var titleTask: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "HelveticaNeue", size: 18)
        title.textColor = .label
        //title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var dateTask: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: "HelveticaNeue", size: 16)
        date.textColor = .label
        //date.numberOfLines = 0
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private lazy var statusTask: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        //label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var informativeTask: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleTask, dateTask])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Inicializador
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTaskCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Métodos
    func setupTaskCell() {
        addSubview(informativeTask)
        addSubview(statusTask)
        backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            informativeTask.centerYAnchor.constraint(equalTo: centerYAnchor),
            informativeTask.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            statusTask.leadingAnchor.constraint(equalTo: informativeTask.trailingAnchor, constant: 10),
            statusTask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            statusTask.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configure(with task: Task) {
        titleTask.text = task.title
        dateTask.text = task.targetDate
        setupStatusLabel(for: task)
    }
    
    private func setupStatusLabel(for task: Task) {
        switch task.status {
        case .notStarted:
            statusTask.text = "Not started"
            statusTask.textColor = .systemRed
            statusTask.backgroundColor = .systemBackground
        case .inProgress:
            statusTask.text = "In progress"
            statusTask.textColor = .systemOrange
            statusTask.backgroundColor = .systemBackground
        case .completed:
            statusTask.text = "Completed"
            statusTask.textColor = .systemGreen
            statusTask.backgroundColor = .systemBackground
        }
    }
    
}
