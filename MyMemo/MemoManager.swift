//
//  MemoManager.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/04.
//

import Foundation


class MemoManager {
    static let myMemo = MemoManager()
    
    var memoList: [Memo] = []
    
    // 메모 추가
    func addMemo(content: String, isCompleted: Bool) {
        let newMemo = Memo(content: content, isCompleted: isCompleted)
        memoList.append(newMemo)
    }

    // 메모 수정
    func updateMemo(at index: Int, newContent: String, isCompleted: Bool, insertDate: Date) {
        guard index >= 0 && index < memoList.count else {
            return
        }
        memoList[index].content = newContent
        memoList[index].isCompleted = isCompleted
        memoList[index].insertDate = insertDate
    }

    // 메모 삭제
    func deleteMemo(at index: Int) {
        guard index >= 0 && index < memoList.count else {
            return
        }
        memoList.remove(at: index)
    }
    
    // 모든 메모 삭제
    func deleteAllCompletedMemos() {
        var indexesToRemove: [Int] = []
        for (index, memo) in memoList.enumerated() {
            if !memo.isCompleted {
                indexesToRemove.append(index)
            }
        }
        // 인덱스를 역순으로 정렬하여 삭제해야 정확한 삭제가 이루어집니다
        let reversedIndexes = indexesToRemove.sorted(by: >)
        for index in reversedIndexes {
            deleteMemo(at: index)
        }
    }

}

