//
//  ComposeViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    // memoManager에 접근하는 변수 생성
    var myMemo = MemoManager.myMemo
    
    // prepare로 받아올 메모
    var prepareMemo: Memo?
    var prepareMemoIndex: Int?
    
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var targetDatePicker: UIDatePicker!
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var memoManagement: UIBarButtonItem!
    
    @IBAction func progressSlider(_ sender: UISlider) {
        let progressValue = sender.value
        prepareMemo?.progress = Int(progressValue)
    }

    @IBAction func save(_ sender: Any) {
        let content = memoTextView.text ?? ""
        let isCompleted = true
        let targetDate = targetDatePicker.date
        let priority = priorityButton.titleLabel?.text ?? "없음"
        let category = categoryButton.titleLabel?.text ?? "일반"
        let progress = Int(progressSlider.value)
        if let prepareMemoIndex = prepareMemoIndex {
            myMemo.updateMemo(at: prepareMemoIndex, newContent: content, isCompleted: isCompleted, insertDate: Date(), targetDate: targetDate, priority: priority, category: category, progress: progress)
        }
        
        // 수정 완료 알람
        let checkAlert = UIAlertController(title: "수정되었습니다.", message: "", preferredStyle: .alert)
        self.present(checkAlert, animated: false)
        dismiss(animated: true)
    }
    
    @IBAction func memoManagement(_ sender: Any) {
        let memoManagementAlert = UIAlertController(title: "", message: "해당 메모를 삭제합니다.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "메모 삭제", style: .default) { [self] (_) in
            self.myMemo.deleteMemo(at: prepareMemoIndex!)
            self.navigationController?.popViewController(animated: true)
        }
        delete.setValue(UIColor.red, forKey: "titleTextColor")
        memoManagementAlert.addAction(cancel)
        memoManagementAlert.addAction(delete)
        self.present(memoManagementAlert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        memoTextView.isScrollEnabled = false
        memoTextView.text = prepareMemo?.content
        targetDatePicker.date = prepareMemo?.targetDate ?? Date()
        setpriorityButton()
        setCategoryButton()
        progressSlider.value = Float(prepareMemo?.progress ?? 0)
    }
    
    func setpriorityButton() {
        let seletedPriority = {(action: UIAction) in
            print(action.title)}
        priorityButton.menu = UIMenu(children: [
            UIAction(title: "없음", state: .on, handler: seletedPriority),
            UIAction(title: "낮음", handler: seletedPriority),
            UIAction(title: "중간", handler: seletedPriority),
            UIAction(title: "높음", handler: seletedPriority)])
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
