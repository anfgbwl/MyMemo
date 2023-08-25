//
//  MemoList.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import Foundation

struct Memo: Codable {
    var content: String     // 메모 타이틀
    var isCompleted: Bool   // 완료여부
    var insertDate: Date    // 작성일
    var targetDate: Date?   // 목표일자
    var priority: String?   // 중요도(우선순위)
    var category: String    // 카테고리
    var progress: Int?      // 진행율
}

// 객체 비교를 위해 Equatable 프로토콜 채택
extension Memo: Equatable {
    static func ==(lhs: Memo, rhs: Memo) -> Bool {
        return lhs.content == rhs.content
    }
}
