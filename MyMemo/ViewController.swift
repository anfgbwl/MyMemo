//
//  ViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBAction func add(_ sender: UIButton) {
        print("버튼 클릭 : 추가")
        let title = "할 일 추가"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: "추가", style: .default) { (_) in
            // 확인 클릭 시 할 일 목록에 추가하는 코드 작성
        }
        alert.addTextField() {(tf) in
            tf.placeholder = "할 일을 입력해주세요."
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    @IBAction func firstButtonTouch(_ sender: UIButton) {
        print("버튼 클릭 : 할 일 확인하기")
    }
    
    @IBAction func secondButtonTouch(_ sender: UIButton) {
        print("버튼 클릭 : 완료한 일 보기")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
     
    
    
}



