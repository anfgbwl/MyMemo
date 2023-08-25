//
//  TableViewCell.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var memoSwitch: UISwitch!
        
    @IBAction func memoSwitch(_ sender: UISwitch) {
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else { return }
        var memo = MemoManager.shared.memoList[indexPath.row]
        memo.isCompleted = sender.isOn
        updateLabelStrikeThrough()
        MemoManager.shared.updateMemo(inSection: indexPath.section, atRow: indexPath.row, newContent: memo.content, isCompleted: memo.isCompleted, insertDate: memo.insertDate, targetDate: memo.targetDate, priority: memo.priority, category: memo.category, progress: memo.progress)
        // 셀을 재로드
        tableView.reloadRows(at: [indexPath], with: .automatic)
        // 로그 출력 (Memo 객체의 내용 출력)
        for memo in MemoManager.shared.memoList { print(memo) }
        print("🤮🤮🤮🤮🤮🤮 확인용: ", memo.isCompleted)
    }
    
    func updateLabelStrikeThrough() {
        if memoSwitch.isOn {
            memoLabel.attributedText = memoLabel.text?.removestrikeThrough()
        } else {
            memoLabel.attributedText = memoLabel.text?.strikeThrough()
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
        
        memoLabel.attributedText = nil
    }
    
}
