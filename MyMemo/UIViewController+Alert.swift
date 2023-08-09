//
//  UIViewController+Alert.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

extension DetailViewController {
    
    // 작성된 메모를 수정하는 Alert
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(cancel)
        
        // updateMemo를 받아 MemoManager updateMemo 함수 실행
        if let updateMemo = self.updateMemo, let prepareMemoIndex = prepareMemoIndex {
            let ok = UIAlertAction(title: "확인", style: .default) { (_) in
                self.myMemo.updateMemo(at: prepareMemoIndex, newContent: updateMemo, isCompleted: true, insertDate: Date())
                self.prepareMemo?.content = updateMemo  // 메모 내용 업데이트
                self.prepareMemo?.insertDate = Date()   // insertDate 업데이트
                self.dateLabel.text = self.formatter.string(from: Date())  // 날짜 라벨 갱신
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


