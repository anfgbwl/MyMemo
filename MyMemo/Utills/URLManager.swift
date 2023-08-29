//
//  URLManager.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/23.
//

import Foundation

class URLManager {
    static let shared = URLManager()
    private init() {
        
    }
    
    // 메인 이미지 불러오는 함수(getJsonData)
    func getJsonData(completion: @escaping (Result<Data, Error>) -> Void) {
        // 메인 이미지 사진 URL
        let mainImageUrl = URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbgdOoN%2Fbtsr4LBjZmp%2FPgZjUykhxAOcuTxiMIlDKk%2Fimg.png")!
        let task = URLSession.shared.dataTask(with: mainImageUrl) { data, response, error in
            if error != nil {
                print("Error: Network Error")
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}


