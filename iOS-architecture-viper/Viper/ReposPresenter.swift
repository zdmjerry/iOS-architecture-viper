//
//  ReposPresenter.swift
//  iOS-architecture-viper
//
//  Created by dingming on 2020/6/1.
//  Copyright © 2020 jerry. All rights reserved.
//

import Foundation

final class ReposPresenter: ReposPresenterType, ReposInteractorOutputsType {
    weak var view: ReposViewType?
    var interactor: ReposInteractorInputsType?
    var wireframe: ReposWireframeType?
    
    private var repos = [Repo]()
    
    func onViewDidLoad() {
        view?.showLoading()
        interactor?.fetchInitialRepos()
    }
    
    func didRetrieveRepos(_ repos: [Repo]) {
        self.repos = repos
        view?.hideLoading()
        view?.didReceiveRepos()
    }
    
    func didChangeQuery(_ query: String?) {
        guard let query = query else { return }
        view?.showLoading()
        interactor?.fetchRepos(for: query)
    }
    
    func didSelectRow(_ indexPath: IndexPath) {
        let id = repos[indexPath.row].id
        view?.displayAlert(for: id)
    }
    
    func numberOfListItems() -> Int {
        return repos.count
    }
    
    func listItem(at index: Int) -> RepoViewModel {
        let item = repos.map { RepoViewModel(repo: $0) }
        return item[index]
    }
}

struct RepoViewModel {
    let name: String
}

extension RepoViewModel {
    init(repo: Repo) {
        self.name = repo.name
    }
}
