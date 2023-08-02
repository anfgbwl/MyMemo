//
//  MemoList.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import Foundation

class Memo {
    var content : String
    var insertDate : Date
    
    init(content : String) {
        self.content = content
        insertDate = Date()
    }
    
    static var dummyMemoList = [
        Memo(content: "첫번째 할일 등록"),
        Memo(content: "두번째 할일 등록")
        
    ]
}
