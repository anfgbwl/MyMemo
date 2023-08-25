//
//  TableViewCell.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var todoSwitch: UISwitch!
        
    @IBAction func todoSwitch(_ sender: UISwitch) {
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else { return }
        var todo = TodoManager.shared.todoList[indexPath.row]
        todo.isCompleted = sender.isOn
        updateLabelStrikeThrough()
        TodoManager.shared.updateTodo(inSection: indexPath.section, atRow: indexPath.row, newContent: todo.content, isCompleted: todo.isCompleted, insertDate: todo.insertDate, targetDate: todo.targetDate, priority: todo.priority, category: todo.category, progress: todo.progress)
        // 셀을 재로드
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func updateLabelStrikeThrough() {
        if todoSwitch.isOn {
            todoLabel.attributedText = todoLabel.text?.removestrikeThrough()
        } else {
            todoLabel.attributedText = todoLabel.text?.strikeThrough()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        todoLabel.attributedText = nil
    }
    
}
