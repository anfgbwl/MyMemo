//
//  MemoManager.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/04.
//

import Foundation

class TodoManager {
    static let shared = TodoManager()
    private var userDefaults = UserDefaults.standard // 접근 제어
    
    var todoList: [Todo] = []
    
    // (접근 제어) 초기화 : UserDefaults를 통해 todo 불러오기
    private init() {
        if let data = userDefaults.data(forKey: "MemoList"),
           let saveTodoList = try? JSONDecoder().decode([Todo].self, from: data) {
            todoList = saveTodoList
        }
    }
    
    // todo 추가
    func addTodo(content: String, isCompleted: Bool, priority: String?, category: String?, progress: Int?) {
        let newTodo = Todo(content: content, isCompleted: isCompleted, insertDate: Date(), priority: priority ?? "없음", category: category ?? "일반", progress:progress ?? 0)
        todoList.append(newTodo)
        print(todoList)
        saveTodoListToUserDefaults()
    }

    // todo 수정
    func updateTodo(inSection section: Int, atRow row: Int, newContent: String, isCompleted: Bool, insertDate: Date, targetDate: Date?, priority: String?, category: String, progress: Int?) {
        let sectionTodoList = todoList.filter { $0.category == categories[section] }
        guard row >= 0 && row < sectionTodoList.count else {
            return
        }
        let originalIndex = todoList.firstIndex { $0 == sectionTodoList[row] }
        if let originalIndex = originalIndex {
            todoList[originalIndex].content = newContent
            todoList[originalIndex].isCompleted = isCompleted
            todoList[originalIndex].insertDate = insertDate
            todoList[originalIndex].targetDate = targetDate
            todoList[originalIndex].priority = priority
            todoList[originalIndex].category = category
            todoList[originalIndex].progress = progress
            saveTodoListToUserDefaults()
        }
    }

    // todo 삭제
    func deleteTodo(inSection section: Int, atRow row: Int) {
        // 나중에 카테고리에 해당하는 todo가 없으면 화면에서 숨기는 형태로 해야겠음(삭제한 코드: section < todoList.count)
        guard section >= 0 else {
            return
        }
        let category = categories[section]
        var todoListInSection = todoList.filter { $0.category == category }
        guard row >= 0 && row < todoListInSection.count else {
            return
        }
        let todo = todoListInSection.remove(at: row)
        
        // todoList에서 해당 todo를 찾아서 삭제
        if let index = todoList.firstIndex(where: { $0 == todo }) {
            todoList.remove(at: index)
        }
        saveTodoListToUserDefaults()
    }
    
    // 모든 메모 삭제
    func deleteAllCompletedTodos() {
        // 완료된 todo의 배열
        var indexesToRemove: [Int] = []
        for (index, todo) in todoList.enumerated() {
            if !todo.isCompleted {
                indexesToRemove.append(index)
            }
        }
        // 인덱스를 역순으로 정렬한 후 삭제(정확한 삭제를 위해)
        let reversedIndexes = indexesToRemove.sorted(by: >)
        for index in reversedIndexes {
            todoList.remove(at: index)
            saveTodoListToUserDefaults()
        }
    }
    
    // 접근 제어
    private func saveTodoListToUserDefaults() {
        if let data = try? JSONEncoder().encode(todoList) {
            userDefaults.set(data, forKey: "TodoList")
        }
    }

}

