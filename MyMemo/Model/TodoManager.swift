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
        if let data = userDefaults.data(forKey: "TodoList"),
           let saveTodoList = try? JSONDecoder().decode([Todo].self, from: data) {
            todoList = saveTodoList
        }
    }
    
    // todo 추가
    func addTodo(content: String, isCompleted: Bool, priority: String?, category: String?, progress: Int?) {
        let newTodo = Todo(content: content, isCompleted: isCompleted, insertDate: Date(), priority: priority ?? "없음", category: category ?? "일반", progress:progress ?? 0)
        todoList.append(newTodo)
        saveTodoListToUserDefaults()
    }

    // todo 수정
    func updateTodo(at index: Int, newContent: String, isCompleted: Bool, insertDate: Date, targetDate: Date?, priority: String?, category: String, progress: Int?) {
        guard index >= 0 && index < todoList.count else {
            return
        }
        todoList[index].content = newContent
        todoList[index].isCompleted = isCompleted
        todoList[index].insertDate = insertDate
        todoList[index].targetDate = targetDate
        todoList[index].priority = priority
        todoList[index].category = category
        todoList[index].progress = progress
        saveTodoListToUserDefaults()
    }

    // todo 삭제
    func deleteTodo(at index: Int) {
        guard index >= 0 && index < todoList.count  else {
            return
        }
        todoList.remove(at: index)
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
        do {
            let data = try JSONEncoder().encode(todoList)
            userDefaults.set(data, forKey: "TodoList")
            print("저장된 리스트", TodoManager.shared.todoList)
        } catch let encodingError {
            print("Error encoding data:", encodingError.localizedDescription)
        }
    }


}

