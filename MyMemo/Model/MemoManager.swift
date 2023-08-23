//
//  MemoManager.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/04.
//

import Foundation


class MemoManager {
    static let shared = MemoManager()
    private var userDefaults = UserDefaults.standard // 접근 제어
    
    var memoList: [Memo] = []
    
    // (접근 제어) 초기화 : UserDefaults를 통해 메모 불러오기
    private init() {
        if let data = userDefaults.data(forKey: "MemoList"),
           let saveMemoList = try? JSONDecoder().decode([Memo].self, from: data) {
            memoList = saveMemoList
        }
    }
    
    // 메모 추가
    func addMemo(content: String, isCompleted: Bool, priority: String?, category: String?, progress: Int?) {
        let newMemo = Memo(content: content, isCompleted: isCompleted, insertDate: Date(), priority: priority ?? "없음", category: category ?? "일반", progress:progress ?? 0)
        memoList.append(newMemo)
        saveMemoListToUserDefaults()
    }

    // 메모 수정
    func updateMemo(at index: Int, newContent: String, isCompleted: Bool, insertDate: Date, targetDate: Date?, priority: String?, category: String?, progress: Int?) {
        guard index >= 0 && index < memoList.count else {
            return
        }
        memoList[index].content = newContent
        memoList[index].isCompleted = isCompleted
        memoList[index].insertDate = insertDate
        memoList[index].targetDate = targetDate
        memoList[index].priority = priority
        memoList[index].category = category
        memoList[index].progress = progress
        saveMemoListToUserDefaults()
    }

    // 메모 삭제
    func deleteMemo(at index: Int) {
        guard index >= 0 && index < memoList.count else {
            return
        }
        memoList.remove(at: index)
        saveMemoListToUserDefaults()
    }
    
    // 모든 메모 삭제
    func deleteAllCompletedMemos() {
        var indexesToRemove: [Int] = []
        for (index, memo) in memoList.enumerated() {
            if !memo.isCompleted {
                indexesToRemove.append(index)
            }
        }
        // 인덱스를 역순으로 정렬한 후 삭제(정확한 삭제를 위해)
        let reversedIndexes = indexesToRemove.sorted(by: >)
        for index in reversedIndexes {
            deleteMemo(at: index)
            saveMemoListToUserDefaults() // 굳이 할 필요 없는 듯.. 어차피 다 삭제할거니까..
        }
    }
    
    // 접근 제어
    private func saveMemoListToUserDefaults() {
        if let data = try? JSONEncoder().encode(memoList) {
            userDefaults.set(data, forKey: "MemoList")
        }
    }

}

