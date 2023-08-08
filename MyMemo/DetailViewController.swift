//
//  ComposeViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    // memoManager에 접근하는 변수 생성
    var myMemo = MemoManager.myMemo
    
    // prepare로 받아올 메모
    var prepareMemo: Memo?
    var prepareMemoIndex: Int?
    
    // 멤버 변수로 memo 선언
    var updateMemo: String? {
        didSet {
            if let updateMemo = updateMemo {
                if updateMemo != prepareMemo?.content {
                    alert(title: "저장하기", message: "저장하시겠습니까?")
                } else {
                    alert(title: "저장하기", message: "내용이 없습니다.")
                }
            }
        }
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var memoManagement: UIBarButtonItem!
    
    @IBAction func save(_ sender: Any) {
        updateMemo = memoTextView.text
        // NotificationCenter : 메모 수정 완료 알림
        NotificationCenter.default.post(name: Notification.Name("MemoUpdated"), object: nil)
    }
    
    @IBAction func memoManagement(_ sender: Any) {
        let memoManagementAlert = UIAlertController(title: "", message: "원하시는 기능을 선택해주세요.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "메모 삭제", style: .default) { [self] (_) in
            self.myMemo.deleteMemo(at: prepareMemoIndex!)
            self.navigationController?.popViewController(animated: true)
        }
        memoManagementAlert.addAction(cancel)
        memoManagementAlert.addAction(delete)
        self.present(memoManagementAlert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.text = prepareMemo?.content
    }
    
}
