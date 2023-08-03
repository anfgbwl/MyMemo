//
//  TableViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class TableViewController: UITableViewController {
    
    // 나중에 시간 표시할 수도 있으니까 남겨두기
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        return f
    }()
        
    @IBAction func addList(_ sender: UIBarButtonItem) {
        print("버튼 클릭 : 추가")
        
        // 인스턴스 생성
        let alert = UIAlertController(title: "할 일 추가", message: "", preferredStyle: .alert) // preferredStyle: .actionSheet -> 텍스트필드 없고 목록만 있는 형태
        
        // Alert textField 작성 가이드
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        
        // 확인 버튼 객체 생성
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in // 트레일링 클로저
            // 내용을 입력했을 때
            if let memoTitle = alert.textFields?[0].text {
                // 입력값을 이용하여 Memo 객체 생성
                let newMemo = Memo(content: memoTitle)
                // Memo 객체를 MemoList 배열에 추가
                Memo.MemoList.append(newMemo)
                self.tableView.reloadData()
            }
        }
        
        // 취소 버튼 객체 생성
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        // Alert에 버튼 객체 등록
        alert.addAction(ok)
        alert.addAction(cancel)
        
        // Alert 띄우기
        self.present(alert, animated: false)

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        tableView.reloadData()
//        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
   }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Memo.MemoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TableViewCell 클래스에서 정의한 셀로 적용
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        // 셀이 사용될 때마다 라벨/스위치 초기화
//        cell.memoLabel.text = nil
            
        // 셀의 기본 텍스트 레이블 행 수 제한 없음
//        cell.textLabel?.numberOfLines = 1
        
        // 셀의 기본 텍스트 레이블에 배열 변수의 값을 할당
        // >> 이게 잘못됐네.. 셀의 기본 텍스트 레이블이 아니라 커스텀 셀안에 있는 memoLabel에 넣어야 함...
        let target = Memo.MemoList[indexPath.row]
        cell.memoLabel?.text = target.content
                
        // 메모 작성날짜 삽입
//        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)
        return cell
    }

}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var memoSwitch: UISwitch!
    @IBAction func memoSwitch(_ sender: UISwitch) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 셀의 재사용
    override func prepareForReuse() {
        super.prepareForReuse()
        
        memoLabel.text = nil
    }
    
//    // 라벨의 크기를 설정하는 메서드 (오버라이드)
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        // 라벨의 크기를 셀의 컨텐츠 뷰의 크기에 맞게 설정
//        memoLabel.frame = memoLabel.bounds
//    }
    
}

