//
//  NetworkingService.swift
//  iOS-architecture-viper
//
//  Created by dingming on 2020/6/1.
//  Copyright © 2020 jerry. All rights reserved.
//
import Foundation


protocol NetworkingService {
    @discardableResult func searchRepos(withQuery query: String, completion: @escaping ([Repo]) -> ()) -> URLSessionDataTask
}

final class NetworkingApi: NetworkingService {
    private let session = URLSession.shared
    
    @discardableResult
    func searchRepos(withQuery query: String, completion: @escaping ([Repo]) -> ()) -> URLSessionDataTask {
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(query)")!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                    let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                        completion([])
                        return
                }
                completion(response.items)
            }
        }
        task.resume()
        return task
    }
}

fileprivate struct SearchResponse: Decodable {
    let items: [Repo]
}
