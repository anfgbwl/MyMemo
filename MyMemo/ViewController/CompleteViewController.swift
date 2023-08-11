//
//  CompleteViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/08.
//

import UIKit

class CompleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myMemo = MemoManager.myMemo
    var completedMemos: [Memo] = []
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        let editAlert = UIAlertController(title: "", message: "모든 메모가 삭제됩니다.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "모든 메모 삭제", style: .default) { [self] (_) in
            self.myMemo.deleteAllCompletedMemos()
            self.navigationController?.popViewController(animated: true)
        }
        delete.setValue(UIColor.red, forKey: "titleTextColor")
        editAlert.addAction(cancel)
        editAlert.addAction(delete)
        self.present(editAlert, animated: true)
    }
    
    @IBOutlet weak var completeTableView: UITableView!
    @IBAction func completeMemoSwitch(_ sender: UISwitch) {
        
        guard let cell = sender.superview?.superview as? CompleteViewCell, // 스위치 상위 뷰 찾기
          let indexPath = completeTableView.indexPath(for: cell) else { return }
    
        let memo = myMemo.memoList[indexPath.row]
        memo.isCompleted = sender.isOn
        myMemo.updateMemo(at: indexPath.row, newContent: memo.content, isCompleted: memo.isCompleted, insertDate: memo.insertDate, targetDate: memo.targetDate, priority: memo.priority, category: memo.category, progress: memo.progress)
        
        if memo.isCompleted {
            // completedMemos 배열에서 제거하고 셀을 삭제
            completedMemos.remove(at: indexPath.row)
            completeTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        completedMemos = myMemo.memoList.filter { $0.isCompleted == false }
        print("\(completedMemos)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func updateMemoStatus(_ notification: Notification) {
            // 메모 상태가 업데이트되었을 때 테이블 뷰 업데이트
            completeTableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedMemos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteViewCell", for: indexPath) as! CompleteViewCell
        let targetMemo = completedMemos[indexPath.row]
        cell.completeMemoLabel?.text = targetMemo.content
        cell.completeMemoSwitch.isOn = targetMemo.isCompleted
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let indexToDelete = indexPath.row
            myMemo.deleteMemo(at: indexToDelete)
            
            // 데이터 소스와 일치하도록 completedMemos 업데이트
            completedMemos = myMemo.memoList.filter { $0.isCompleted == false }
            // 애니메이션 블록을 만들어 주는 메소드(beginUpdates/endUpdates)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

class CompleteViewCell : UITableViewCell {
    var myMemo = MemoManager.myMemo
    
    @IBOutlet weak var completeMemoLabel: UILabel!
    @IBOutlet weak var completeMemoSwitch: UISwitch!
    
    
}
