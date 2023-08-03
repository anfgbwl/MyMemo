//
//  MemoList.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import Foundation

class Memo {
    var content : String
//    var insertDate : Date
    
    init(content : String) {
        self.content = content
//        insertDate = Date()
    }
    
    static var MemoList = [
        Memo(content: "Lv2 기능 구현하기"),
        Memo(content: "TIL 작성하기")
        
    ]
}
