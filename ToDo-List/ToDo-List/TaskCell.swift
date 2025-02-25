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
        title.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 18)
        title.textColor = .label
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var dateTask: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 16)
        date.textColor = .label
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private lazy var statusTask: UILabel = {
        let status = UILabel()
        status.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 16)
        return status
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
        contentView.addSubview(titleTask)
        contentView.addSubview(dateTask)
        contentView.addSubview(statusTask)
        NSLayoutConstraint.activate([
            titleTask.topAnchor.constraint(equalTo: topAnchor),
            titleTask.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleTask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            dateTask.topAnchor.constraint(equalTo: titleTask.bottomAnchor, constant: 5),
            dateTask.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateTask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            statusTask.topAnchor.constraint(equalTo: dateTask.bottomAnchor, constant: 5),
            statusTask.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            statusTask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with task: Task) {
        titleTask.text = task.title
        //dateTask.text = task.targetDate
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
