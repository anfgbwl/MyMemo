//
//  MemoList.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import Foundation

class Memo: CustomStringConvertible  {
    var content: String
    var isCompleted: Bool
//    var insertDate: Date

    init(content: String, isCompleted: Bool) {
        self.content = content
        self.isCompleted = isCompleted
//    insertDate = Date()
    }
    
    // 메모에 어떤 값이 들어있는지 확인
    var description: String {
        return "Content: \(content), isCompleted: \(isCompleted)"
    }
}
