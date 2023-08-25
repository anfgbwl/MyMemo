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
    
    
    
//    func getRandomCatImage() {
//        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/images/search?format=json&limit=10")!,timeoutInterval: Double.infinity)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("live_lg7w2mv5QqCVQeTi0qOATauOvHylcHZu4hKxHD0cyBmf2E8N9laG1unjcjMZoNvB", forHTTPHeaderField: "x-api-key")
//
//        request.httpMethod = "GET"
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            return
//          }
//          print(String(data: data, encoding: .utf8)!)
//        }
//
//        task.resume()
//
//    }
    
    
    // 랜덤 고양이 사진 불러오기(API 사용)
//    func getRandomCatImage(completion: @escaping (Result<Any, Error>) -> Void) {
//        let ramdomCatImageurl = URL(string: "https://api.thecatapi.com/v1/images/search")!
//        let task = URLSession.shared.dataTask(with: ramdomCatImageurl) { data, response, error in
//            if error != nil {
//                print("Error: Network Error")
//                completion(.failure(NetworkError.emptyResponse))
//                return
//            }
//            guard let Jsondata = data else {
//                completion(.failure(NetworkError.emptyResponse))
//                return
//            }
//            do {
//                let decodedData = try JSONDecoder().decode(RandomImage.self, from: Jsondata)
//                completion(.success(decodedData))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
    
//    // 랜덤 고양이 사진 불러오기(API 사용)
//    func getRandomCatImage() async throws -> RandomImage {
//        let ramdomCatImageurl = URL(string: "https://api.thecatapi.com/v1/images/search")!
//        let (data, response) = try await URLSession.shared.data(from: ramdomCatImageurl)
//        guard let response = response as? HTTPURLResponse else {
//            throw NetworkError.emptyResponse
//        }
//        do {
//            return try JSONDecoder().decode(RandomImage.self, from: data)
//        } catch {
//            throw NetworkError.emptyResponse
//        }
//    }
    
    
}

enum NetworkError: Error {
    case emptyResponse
}
