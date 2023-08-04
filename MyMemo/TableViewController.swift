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
    
    // switch 상태 확인하는 변수
//    var switchStates = [Bool]()
    
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
                // MemoManager addMemo 함수 실행
                self.myMemo.addMemo(content: memoTitle)
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
        
        tableView.reloadData()
//        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMemo.memoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TableViewCell 클래스에서 정의한 셀로 적용
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        // 셀이 사용될 때마다 라벨/스위치 초기화
//        cell.memoLabel.text = nil
            
        // 셀의 기본 텍스트 레이블 행 수 제한 없음
//        cell.textLabel?.numberOfLines = 1
        
        // 셀의 기본 텍스트 레이블에 배열 변수의 값을 할당
        let target = myMemo.memoList[indexPath.row]
        cell.memoLabel?.text = target.content
                
        // 메모 작성날짜 삽입
//        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // 선택한 셀의 인덱스와 입력값을 전달
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
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var memoSwitch: UISwitch!
    
    // 이전 텍스트를 저장할 변수 추가
    private var previousText: String?
    
    // 스위치 상태를 저장하는 변수
    var isSwitchOn = true
    
    @IBAction func memoSwitch(_ sender: UISwitch) {
        isSwitchOn = sender.isOn
        updateLabelStrikeThrough()
    }
    
    func updateLabelStrikeThrough() {
        if isSwitchOn {
            // 스위치가 on인 경우 취소선을 없애고 이전 텍스트 복원
            // >> 위아래 순서 바꾸니까 해결...
            memoLabel.attributedText = nil
            memoLabel.text = previousText
        } else {
            // 스위치가 off인 경우 취소선을 추가하고 이전 텍스트 저장
            previousText = memoLabel.text
            memoLabel.attributedText = memoLabel.text?.strikeThrough()
        }
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
        
        memoLabel.attributedText = nil
    }
    
//    // 라벨의 크기를 설정하는 메서드 (오버라이드)
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        // 라벨의 크기를 셀의 컨텐츠 뷰의 크기에 맞게 설정
//        memoLabel.frame = memoLabel.bounds
//    }
    
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
