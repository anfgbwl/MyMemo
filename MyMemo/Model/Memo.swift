//
//  MemoList.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import Foundation

class Memo: CustomStringConvertible  {
    var content: String     // 메모 타이틀
    var isCompleted: Bool   // 완료여부
    var insertDate: Date   // 작성일
    var targetDate: Date?   // 목표일자
    var priority: String?   // 중요도(우선순위)
    var category: String?   // 카테고리
    var progress: Int?      // 진행율
    

    init(content: String, isCompleted: Bool, priority: String, category: String, progress: Int) {
        self.content = content
        self.isCompleted = isCompleted
        insertDate = Date()
        targetDate = Date()
        self.priority = priority
        self.category = category
        self.progress = progress
    }
    
    // 메모 확인
    var description: String {
        return "Content: \(content), isCompleted: \(isCompleted), Date: \(insertDate), targetDate: \(targetDate ?? nil), priority: \(priority ?? nil), category: \(category ?? nil), progress: \(progress ?? nil)"
    }
}
