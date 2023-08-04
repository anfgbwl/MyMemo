//
//  MemoManager.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/04.
//

import Foundation

class MemoManager {
    // 외부에서 접근 가능한 객체 생성(MemoManager.myMemo로 인스턴스에 접근 가능)
    static let myMemo = MemoManager()
    
    // (주의) 나중에 title, subtitle 할거니까 인지하고 있어야 함!! 딕셔너리로 변경될 수 있음
    var memoList: [Memo] = []
    
    // MemoManager 기능!!
    // 메모 추가
    func addMemo(content: String) {
        let newMemo = Memo(content: content)
        memoList.append(newMemo)
    }

    // 메모 수정
    func updateMemo(at index: Int, newContent: String) {
        guard index >= 0 && index < memoList.count else {
            return
        }
        memoList[index].content = newContent
    }
    
    // 메모 삭제
    func deleteMemo(at index: Int) {
        guard index >= 0 && index < memoList.count else {
            return
        }
        memoList.remove(at: index)
    }
    
}
