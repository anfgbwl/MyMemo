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
    let categories = Array(Set(MemoManager.shared.memoList.map { $0.category })).sorted()
    
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
        print(memoList)
        saveMemoListToUserDefaults()
    }

    // 메모 수정
    func updateMemo(inSection section: Int, atRow row: Int, newContent: String, isCompleted: Bool, insertDate: Date, targetDate: Date?, priority: String?, category: String, progress: Int?) {
        let sectionMemoList = memoList.filter { $0.category == categories[section] }
        guard row >= 0 && row < sectionMemoList.count else {
            return
        }
        var memoToUpdate = sectionMemoList[row]
        memoToUpdate.content = newContent
        memoToUpdate.isCompleted = isCompleted
        memoToUpdate.insertDate = insertDate
        memoToUpdate.targetDate = targetDate
        memoToUpdate.priority = priority
        memoToUpdate.category = category
        memoToUpdate.progress = progress
        if let indexToUpdate = memoList.firstIndex(where: { $0.content == memoToUpdate.content }) {
            memoList[indexToUpdate] = memoToUpdate
            saveMemoListToUserDefaults()
            print("🤮🤮🤮🤮🤮🤮 확인용: ", memoToUpdate.isCompleted)
        }
    }

    // 메모 삭제
    func deleteMemo(inSection section: Int, atRow row: Int) {
        guard section >= 0 && section < memoList.count else {
            return
        }
        let category = categories[section]
        print("🤮🤮🤮🤮🤮🤮", category)
        var memoListInSection = memoList.filter { $0.category == category }
        print("🤮🤮🤮🤮🤮🤮", memoListInSection)
        guard row >= 0 && row < memoListInSection.count else {
            return
        }
        let memo = memoListInSection.remove(at: row)
        
        // memoList에서 해당 memo를 찾아서 삭제
//        if let index = memoList.firstIndex(where: { $0 === memo }) {
//            memoList.remove(at: index)
//        }
        saveMemoListToUserDefaults()
    }
    
    // 모든 메모 삭제
    func deleteAllCompletedMemos() {
        // 완료된 메모의 배열
        var indexesToRemove: [Int] = []
        for (index, memo) in memoList.enumerated() {
            if !memo.isCompleted {
                indexesToRemove.append(index)
            }
        }
        // 인덱스를 역순으로 정렬한 후 삭제(정확한 삭제를 위해)
        let reversedIndexes = indexesToRemove.sorted(by: >)
        for index in reversedIndexes {
            memoList.remove(at: index)
        }
    }
    
    // 접근 제어
    private func saveMemoListToUserDefaults() {
        if let data = try? JSONEncoder().encode(memoList) {
            userDefaults.set(data, forKey: "MemoList")
        }
    }

}

