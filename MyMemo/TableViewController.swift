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
        return f
    }()
    
    var memo = [Memo]()
    
    @IBAction func addList(_ sender: Any) {
        // sender를 UIButton으로 하니까 안떴음... Any로 해야 뜨네..?
        print("버튼 클릭 : 추가")
        let title = "할 일 추가"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: "추가", style: .default) { (_) in
            // 확인 클릭 시 할 일 목록에 추가하는 코드 작성
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        alert.addTextField() {(tf) in
            tf.placeholder = "할 일을 입력해주세요."
        }
        self.present(alert, animated: true)
    }
    
    //    var strikeThrough = false
//    @IBAction func listSwitch(_ sender: UISwitch) {
//        strikeThrough = sender.isOn
//        tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Memo.dummyMemoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
            
        let target = Memo.dummyMemoList[indexPath.row]
//        cell.textLabel?.text = nil // 하 어이없어 전에 써논거 남아서 겹쳐나옴 ㅋㅋㅋㅋㅋㅋ
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)
        // 메모 작성날짜 삽입
        
//        let labelAttributedString = NSMutableAttributedString(string: "할 일 목록")
//        if strikeThrough {
//            labelAttributedString.addAttribute(.strikethroughStyle, value: 1, range: NSRange(location: 0, length: labelAttributedString.length))
//        } else {
//            labelAttributedString.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: labelAttributedString.length))
//        }
//        cell.toDoListLabel.attributedText = labelAttributedString

        return cell
    }

}

class TableViewCell: UITableViewCell {
    
//    @IBOutlet weak var toDoListLabel: UILabel!
//    @IBOutlet weak var listSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

