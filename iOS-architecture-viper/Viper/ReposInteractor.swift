//
//  ReposInteractor.swift
//  iOS-architecture-viper
//
//  Created by dingming on 2020/6/1.
//  Copyright © 2020 jerry. All rights reserved.
//


import Foundation

final class ReposInteractor: ReposInteractorInputsType {
    weak var presenter: ReposInteractorOutputsType?
    
    // Dependencies
    private let dataManager: ReposRemoteDataManager
    private let validator = ThrottledTextFieldValidator()
    
    init(dataManager: ReposRemoteDataManager = ReposRemoteDataManager()) {
        self.dataManager = dataManager
    }
    
    // ReposInteractorInputsProtocol
    func fetchRepos(for query: String) {
        if (query.isEmpty) {
            startFetching(for: "rxswift")
        } else {
            validator.validate(query: query) { [weak self] query in
                guard let strongSelf = self,
                    let query = query else { return }
                strongSelf.startFetching(for: query)
            }
        }
    }
    
    func fetchInitialRepos() {
        startFetching(for: "rxswift")
    }
    
    private func startFetching(for query: String) {
        dataManager.fetchRepos(for: query, completion: { [weak self] repos in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.didRetrieveRepos(repos)
        })
    }
}
