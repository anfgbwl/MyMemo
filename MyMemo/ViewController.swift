//
//  ViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBAction func firstButtonTouch(_ sender: UIButton) {
        print("버튼 클릭 : 할 일 확인하기")
    }
    @IBAction func secondButtonTouch(_ sender: UIButton) {
        print("버튼 클릭 : 완료한 일 보기")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgMain = UIImage(named: "team3.png")
        imgView.image = imgMain
    }

    
}


