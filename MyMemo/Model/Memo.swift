//
//  MemoList.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import Foundation

struct Memo {
    var content: String     // 메모 타이틀
    var isCompleted: Bool   // 완료여부
    var insertDate: Date   // 작성일
    var targetDate: Date?   // 목표일자
    var priority: String?   // 중요도(우선순위)
    var category: String?   // 카테고리
    var progress: Int?      // 진행율
}
