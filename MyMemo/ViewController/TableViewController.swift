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
    // memoManager에 접근하는 변수 생성
    var myMemo = MemoManager.myMemo
        
    @IBAction func addList(_ sender: UIBarButtonItem) {
        print("버튼 클릭 : 추가")
        
        // alert 콘솔창 오류 메세지 없애는 방법 알아보기
        let alert = UIAlertController(title: "할 일 추가", message: "", preferredStyle: .alert)
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            if let memoTitle = alert.textFields?[0].text {
                self.myMemo.addMemo(content: memoTitle, isCompleted: true, priority: "", category: "", progress: 0)
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
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMemo.memoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let target = myMemo.memoList[indexPath.row]
        cell.memoLabel?.text = target.content
        cell.memoSwitch.isOn = target.isCompleted
        cell.dateLabel?.text = formatter.string(from: target.insertDate)
        cell.updateLabelStrikeThrough()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let indexToDelete = indexPath.row
            myMemo.deleteMemo(at: indexToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    let selectedMemoIndex = selectedIndexPath.row
                    let prepareMemo = myMemo.memoList[selectedMemoIndex]
                    destination.prepareMemoIndex = selectedMemoIndex
                    destination.prepareMemo = prepareMemo
                }
            }
        }
    }

}

class TableViewCell: UITableViewCell {
    // memoManager에 접근하는 변수 생성
    var myMemo = MemoManager.myMemo
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var memoSwitch: UISwitch!
        
    @IBAction func memoSwitch(_ sender: UISwitch) {
        guard let tableView = superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else { return }
        var memo = myMemo.memoList[indexPath.row]
        memo.isCompleted = sender.isOn
        updateLabelStrikeThrough()
        myMemo.updateMemo(at: indexPath.row, newContent: memo.content, isCompleted: memo.isCompleted, insertDate: memo.insertDate, targetDate: memo.targetDate, priority: memo.priority, category: memo.category, progress: memo.progress)
        
        // 로그 출력 (Memo 객체의 내용 출력)
        for memo in myMemo.memoList { print(memo) }
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
