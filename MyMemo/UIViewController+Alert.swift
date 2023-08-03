//
//  UIViewController+Alert.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

extension ComposeViewController {
    
    // 작성된 메모를 수정하는 알람
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(cancel)
        
        // 멤버 변수 memo를 사용하도록 변경
        if let memo = self.memo {
            let ok = UIAlertAction(title: "확인", style: .default) { (_) in
                let newMemo = Memo(content: memo)
                Memo.MemoList.append(newMemo)
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
        }
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
}


