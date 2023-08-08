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
    
    @IBOutlet weak var completeTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        completedMemos = myMemo.memoList.filter { $0.isCompleted == false }
        print("\(completedMemos)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedMemos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteViewCell", for: indexPath) as! CompleteViewCell
        let targetMemo = completedMemos[indexPath.row]
        cell.completeMemoLabel?.text = targetMemo.content
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
    @IBOutlet weak var completeMemoLabel: UILabel!

}
