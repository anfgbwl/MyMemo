//
//  TableViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class TableViewController: UITableViewController {
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
                self.myMemo.addMemo(content: memoTitle, isCompleted: true)
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
        cell.updateLabelStrikeThrough()
        cell.memo = target
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
    @IBOutlet weak var memoSwitch: UISwitch!
    
//    // 이전 텍스트를 저장할 변수 추가
    private var previousText: String?
//
//    // 스위치 상태를 저장하는 변수
//    var isSwitchOn = true
    
    // 스위치 상태 가져오기
    var memo: Memo? {
        didSet {
            guard let memo = memo else { return }
            memoLabel.text = memo.content
            memoSwitch.isOn = memo.isCompleted
        }
    }
    
    @IBAction func memoSwitch(_ sender: UISwitch) {
//        isSwitchOn = sender.isOn
//        updateLabelStrikeThrough()
        guard let memo = memo else { return }
        memo.isCompleted = sender.isOn
        updateLabelStrikeThrough()
    }
    
    func updateLabelStrikeThrough() {
        // 스위치가 on인 경우 취소선을 없애고 이전 텍스트 복원
        if memoSwitch.isOn {
            memoLabel.attributedText = nil
            memoLabel.text = previousText
            
        } else {
            // 스위치가 off인 경우 취소선을 추가
            previousText = memoLabel.text
            memoLabel.attributedText = memoLabel.text?.strikeThrough()
        }
//        if isSwitchOn {
//            // 스위치가 on인 경우 취소선을 없애고 이전 텍스트 복원
//            memoLabel.attributedText = nil
//            memoLabel.text = previousText
////            if let tableView = superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
////                let memoIndex = indexPath.row
////                myMemo.updateMemo(at: memoIndex, newContent: memoLabel.text!, isCompleted: true)
////            }
//        } else {
//            // 스위치가 off인 경우 취소선을 추가하고 이전 텍스트 저장
//            previousText = memoLabel.text
//            memoLabel.attributedText = memoLabel.text?.strikeThrough()
////            if let tableView = superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
////                let memoIndex = indexPath.row
////                myMemo.updateMemo(at: memoIndex, newContent: memoLabel.text!, isCompleted: false)
////            }
//
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//     셀의 재사용
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        memoLabel.attributedText = nil
        
//        memoLabel.text = nil
//        memoSwitch.isOn = true

//        isSwitchOn = true // 스위치 상태 초기화
        // 스위치의 상태를 기존 상태로 설정
//        memoSwitch.isOn = ((memo?.isCompleted) != nil)
        updateLabelStrikeThrough() // 셀 상태에 따라 라벨에 취소선 적용
    }
    
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
