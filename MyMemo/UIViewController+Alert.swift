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
                self.myMemo.updateMemo(at: prepareMemoIndex, newContent: updateMemo, isCompleted: true)
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // 작성된 메모를 삭제하는 Alert
//    func managementAlert(
    
}


