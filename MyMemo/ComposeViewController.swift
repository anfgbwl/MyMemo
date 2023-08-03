//
//  ComposeViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class ComposeViewController: UIViewController {
    // 멤버 변수로 memo 선언
    var memo: String?
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func close(_ sender: Any) {
        //창 사라짐
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        if let memo = memoTextView.text,
           memo.count > 0 {
            // save 함수의 지역 변수 memo 값을 멤버 변수 memo에 할당
            self.memo = memo
            
            // 여기 Alert는 확인누르면 메모리스트에 추가, 취소는 저장안하기
            // 타이틀, 메세지만 설정하고 확인/취소는 UIViewController+Alert 파일에서 설정한 행위 이행
            alert(title: "저장하기", message: "저장하시겠습니까?")
            
            
        } else {
            // 여기 Alert는 확인만 뜨게 하기
            alert(title: "저장하기", message: "내용이 없습니다.")
            return
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
