//
//  TableViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class TableViewController: UITableViewController {
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    let categories = Array(Set(MemoManager.shared.memoList.map { $0.category })).sorted()
        
    @IBAction func addList(_ sender: UIBarButtonItem) {
        print("버튼 클릭 : 추가")
        
        // alert 콘솔창 오류 메세지 없애는 방법 알아보기
        let alert = UIAlertController(title: "할 일 추가", message: "", preferredStyle: .alert)
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            if let memoTitle = alert.textFields?[0].text {
                MemoManager.shared.addMemo(content: memoTitle, isCompleted: true, priority: "없음", category: "일반", progress: 0)
                self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: false)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }

    // 섹션 헤더 높이
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    // 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    // 섹션 내 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 카테고리 배열의 값과 memoList의 카테고리 값이 매칭되면 해당 memoList의 카운트를 반환
        let category = categories[section]
        return MemoManager.shared.memoList.filter { $0.category == category }.count
    }

    // 셀의 내용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let category = categories[indexPath.section]
        let memoListInSection = MemoManager.shared.memoList.filter { $0.category == category }
        let target = memoListInSection[indexPath.row]
        cell.memoLabel?.text = target.content
        cell.memoSwitch.isOn = target.isCompleted
        cell.dateLabel?.text = formatter.string(from: target.insertDate)
        cell.updateLabelStrikeThrough()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let indexToDelete = indexPath.row
            MemoManager.shared.deleteMemo(at: indexToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    let selectedMemoIndex = selectedIndexPath.row
                    let section = selectedIndexPath.section
                    let category = categories[section]
                    let prepareMemo = MemoManager.shared.memoList.filter { $0.category == category }[selectedMemoIndex]
                    destination.prepareMemoIndex = selectedMemoIndex
                    destination.prepareMemo = prepareMemo
                }
            }
        }
    }

}

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
        MemoManager.shared.updateMemo(at: indexPath.row, newContent: memo.content, isCompleted: memo.isCompleted, insertDate: memo.insertDate, targetDate: memo.targetDate, priority: memo.priority, category: memo.category, progress: memo.progress)
        
        // 로그 출력 (Memo 객체의 내용 출력)
        for memo in MemoManager.shared.memoList { print(memo) }
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

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    func removestrikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
