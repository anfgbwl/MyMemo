//
//  CompleteViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/08.
//

import UIKit

class CompleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var completedTodos: [Todo] = []
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let editAlert = UIAlertController(title: "", message: "모든 항목이 삭제됩니다.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "모든 항목 삭제", style: .default) { [self] (_) in
            TodoManager.shared.deleteAllCompletedTodos()
            self.navigationController?.popViewController(animated: true)
        }
        delete.setValue(UIColor.red, forKey: "titleTextColor")
        editAlert.addAction(cancel)
        editAlert.addAction(delete)
        self.present(editAlert, animated: true)
    }
    
    @IBOutlet weak var completeTableView: UITableView!
    @IBAction func completeMemoSwitch(_ sender: UISwitch) {
        
        guard let cell = sender.superview?.superview as? CompleteViewCell,
              let indexPath = completeTableView.indexPath(for: cell) else { return }
        let originalIndex = TodoManager.shared.todoList.firstIndex { $0 == completedTodos[indexPath.row] } ?? 0
        var completedTodo = TodoManager.shared.todoList[originalIndex]
        completedTodo.isCompleted = sender.isOn
        TodoManager.shared.updateTodo(at: originalIndex, newContent: completedTodo.content, isCompleted: completedTodo.isCompleted, insertDate: completedTodo.insertDate, targetDate: completedTodo.targetDate, priority: completedTodo.priority, category: completedTodo.category, progress: completedTodo.progress)
        
        if completedTodo.isCompleted {
            // completedMemos 배열에서 제거하고 셀을 삭제
            completedTodos.remove(at: indexPath.row)
            completeTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        completedTodos = TodoManager.shared.todoList.filter { $0.isCompleted == false }
        print("\(completedTodos)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func updateMemoStatus(_ notification: Notification) {
            // 메모 상태가 업데이트되었을 때 테이블 뷰 업데이트
            completeTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteViewCell", for: indexPath) as! CompleteViewCell
        let targetTodo = completedTodos[indexPath.row]
        cell.completeMemoLabel?.text = targetTodo.content
        cell.completeMemoSwitch.isOn = targetTodo.isCompleted
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoListInSection = TodoManager.shared.todoList.filter { $0.category == categories[indexPath.section] }
            let todo = todoListInSection[indexPath.row]
            let originalIndex = TodoManager.shared.todoList.firstIndex { $0 == todo } ?? 0
            TodoManager.shared.deleteTodo(at: originalIndex)
            
            // 데이터 소스와 일치하도록 completedMemos 업데이트
            completedTodos = TodoManager.shared.todoList.filter { $0.isCompleted == false }
            // 애니메이션 블록을 만들어 주는 메소드(beginUpdates/endUpdates)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

class CompleteViewCell : UITableViewCell {
    
    @IBOutlet weak var completeMemoLabel: UILabel!
    @IBOutlet weak var completeMemoSwitch: UISwitch!
    
}
