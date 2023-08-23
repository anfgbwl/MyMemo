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
    
    let mainImageUrl = URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbgdOoN%2Fbtsr4LBjZmp%2FPgZjUykhxAOcuTxiMIlDKk%2Fimg.png")!
    func getJsonData(completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: mainImageUrl) { data, response, error in
            if let error {
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

enum NetworkError: Error {
    case emptyResponse
}
