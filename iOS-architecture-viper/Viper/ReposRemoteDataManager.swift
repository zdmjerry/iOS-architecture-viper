//
//  ReposRemoteDataManager.swift
//  iOS-architecture-viper
//
//  Created by dingming on 2020/6/1.
//  Copyright © 2020 jerry. All rights reserved.
//
import Foundation

final class ReposRemoteDataManager: ReposRemoteDataManagerType {
    private let networkingService: CancellableReposFetchable
    
    init(networkingService: CancellableReposFetchable = CancellableReposFetcher()) {
        self.networkingService = networkingService
    }
    
    func fetchRepos(for query: String, completion: @escaping ([Repo]) -> ()) {
        networkingService.fetchRepos(withQuery: query, completion: completion)
    }
}
