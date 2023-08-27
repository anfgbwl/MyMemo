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
        
    @IBAction func addList(_ sender: UIBarButtonItem) {
        print("버튼 클릭 : 추가")
        // alert 콘솔창 오류 메세지 없애는 방법 알아보기
        let alert = UIAlertController(title: "할 일 추가", message: "", preferredStyle: .alert)
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            if let todoTitle = alert.textFields?[0].text, todoTitle.count != 0 {
                TodoManager.shared.addTodo(content: todoTitle, isCompleted: true, priority: "없음", category: "일반", progress: 0)
                self.tableView.reloadData() // Alert에서 메모 추가하게 되면 바로 테이블뷰에 띄워주기
                print("🚨 추가된 내용: ", todoTitle)
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
        
        setUpTableViewHeaderFooter()
        self.tableView.reloadData()
    }

    // 섹션 헤더 높이
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    // 섹션 헤더 타이틀(카테고리)
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    // 섹션 헤더 배경색
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        header?.textLabel?.textColor = .white
        header?.contentView.backgroundColor = UIColor.tintColor
        return header
    }
    
    // 섹션 푸터 높이
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    // 섹션 푸터 라벨
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "customHeader")
        footer?.textLabel?.text = "완료 n 건 / 미완료 n 건"
        footer?.contentView.backgroundColor = UIColor.systemGray6
        return footer
    }
    
    // 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    // 섹션 내 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 카테고리 배열의 값과 memoList의 카테고리 값이 매칭되면 해당 memoList의 카운트를 반환
        let category = categories[section]
        return TodoManager.shared.todoList.filter { $0.category == category }.count
    }

    // 셀의 내용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let category = categories[indexPath.section]
        let todoListInSection = TodoManager.shared.todoList.filter { $0.category == category }
        let target = todoListInSection[indexPath.row]
        cell.todoLabel?.text = target.content
        cell.todoSwitch.isOn = target.isCompleted
        cell.dateLabel?.text = formatter.string(from: target.insertDate)
        cell.updateLabelStrikeThrough()
        return cell
    }
    
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let indexToDelete = indexPath.row
            let section = indexPath.section
            TodoManager.shared.deleteTodo(inSection: section, atRow: indexToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    let section = selectedIndexPath.section // 카테고리
                    let selectedTodoIndex = selectedIndexPath.row // 카테고리 내 todo
                    let category = categories[section]
                    let prepareTodo = TodoManager.shared.todoList.filter { $0.category == category }[selectedTodoIndex]
                    destination.prepareTodoIndex = selectedIndexPath
                    destination.prepareTodo = prepareTodo
                }
            }
        }
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

extension TableViewController {
    func setUpTableViewHeaderFooter() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        header.backgroundColor = .systemGray6
        footer.backgroundColor = .black
        
        let headerTitle = UILabel(frame: header.bounds)
        headerTitle.text = "⁉️ 뭘하면 될까용 ⁉️"
        headerTitle.textAlignment = .center
        
        let footerTitle = UILabel(frame: header.bounds)
        footerTitle.text = "☠️ 완료 n 건 / 미완료 n 건 ☠️"
        footerTitle.textColor = .white
        footerTitle.textAlignment = .center
        
        header.addSubview(headerTitle)
        footer.addSubview(footerTitle)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "customHeader")
    }
}
