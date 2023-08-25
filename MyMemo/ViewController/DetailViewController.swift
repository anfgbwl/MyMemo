//
//  ComposeViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    // prepare로 받아올 todo
    var prepareTodoIndex: IndexPath?
    var prepareTodo: Todo?
    
    @IBOutlet weak var todoTextView: UITextView!
    @IBOutlet weak var targetDatePicker: UIDatePicker!
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var progressValueLabel: UILabel!
    @IBOutlet weak var todoManagement: UIBarButtonItem!
    
    @IBAction func progressSlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
        let progressValue = sender.value
        prepareTodo?.progress = Int(progressValue)
        progressValueLabel.text = String(Int(progressValue))
    }
    
    @IBAction func save(_ sender: Any) {
        let content = todoTextView.text ?? "비어있음"
        let isCompleted = true
        let targetDate = targetDatePicker.date
        let priority = priorityButton.titleLabel?.text ?? "없음"
        let category = categoryButton.titleLabel?.text ?? "일반"
        let progress = Int(progressSlider.value)
        if let prepareTodoIndex = prepareTodoIndex {
            let section = prepareTodoIndex.section
            let row = prepareTodoIndex.row
            TodoManager.shared.updateTodo(inSection: section, atRow: row, newContent: content, isCompleted: isCompleted, insertDate: Date(), targetDate: targetDate, priority: priority, category: category, progress: progress)
        }
        
        // 수정 완료 알람
        let checkAlert = UIAlertController(title: "수정되었습니다.", message: "", preferredStyle: .alert)
        self.present(checkAlert, animated: false)
        dismiss(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func todoManagement(_ sender: Any) {
        let todoManagementAlert = UIAlertController(title: "", message: "해당 항목을 삭제합니다.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "삭제", style: .default) { [self] (_) in
            guard let prepareTodoIndex = self.prepareTodoIndex else {
                return
            }
            let section = prepareTodoIndex.section
            let row = prepareTodoIndex.row
            TodoManager.shared.deleteTodo(inSection: section, atRow: row)
            self.navigationController?.popViewController(animated: true)
        }
        delete.setValue(UIColor.red, forKey: "titleTextColor")
        todoManagementAlert.addAction(cancel)
        todoManagementAlert.addAction(delete)
        self.present(todoManagementAlert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if prepareTodo?.priority == "", prepareTodo?.category == "" {
            priorityButton.setTitle("없음", for: .normal)
            categoryButton.setTitle("일반", for: .normal)
        } else {
            priorityButton.setTitle(prepareTodo?.priority, for: .normal)
            priorityButton.titleLabel?.text = prepareTodo?.priority
            categoryButton.setTitle(prepareTodo?.category, for: .normal)
            categoryButton.titleLabel?.text = prepareTodo?.category
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextView.delegate = self
        todoTextView.isScrollEnabled = false
        todoTextView.text = prepareTodo?.content
        targetDatePicker.date = prepareTodo?.targetDate ?? Date()
        progressSlider.value = Float(prepareTodo?.progress ?? 0)
        progressValueLabel.text = String(Int(progressSlider.value))
        progressValueLabel.textColor = .link
        setProgressSlider()
        setPriorityButton()
        setCategoryButton()
    }
    
    
    func setPriorityButton() {
        let seletedPriority = {(action: UIAction) in
        }
        priorityButton.menu = UIMenu(children: [
            UIAction(title: "없음", handler: seletedPriority),
            UIAction(title: "낮음", handler: seletedPriority),
            UIAction(title: "중간", handler: seletedPriority),
            UIAction(title: "높음", attributes: .destructive, handler: seletedPriority)])
        priorityButton.showsMenuAsPrimaryAction = true
        priorityButton.changesSelectionAsPrimaryAction = true
    }
    
    func setCategoryButton() {
        let normal = UIAction(title: "일반", handler: { _ in print("일반") })
        let pet = UIAction(title: "반려동물", handler: { _ in print("반려동물") })
        let home = UIAction(title: "집", handler: { _ in print("집") })
        let work = UIAction(title: "과제", handler: { _ in print("과제") })
        let exercise = UIAction(title: "운동", handler: { _ in print("운동") })
        self.categoryButton.menu = UIMenu(title: "", children: [normal, pet, home, work, exercise])
        self.categoryButton.showsMenuAsPrimaryAction = true
        self.categoryButton.changesSelectionAsPrimaryAction = true
    }
    
    func setProgressSlider() {
        progressSlider.setThumbImage(UIImage(named: "sliderThumb1"), for: .normal)
    }
}

extension DetailViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach{ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
