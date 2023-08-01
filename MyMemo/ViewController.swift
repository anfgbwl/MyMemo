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
    @IBAction func firstButtonTouch(_ sender: UIButton) {
        print("버튼 클릭 : 할 일 확인하기")
//        self.firstButton.backgroundColor = .white
//        self.firstButton.tintColor = .blue
        // (목표) 버튼 눌렀을 때 배경, 폰트 색상 바꾸기
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


