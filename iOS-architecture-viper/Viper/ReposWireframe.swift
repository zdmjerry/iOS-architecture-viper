//
//  ReposWireframe.swift
//  iOS-architecture-viper
//
//  Created by dingming on 2020/6/1.
//  Copyright © 2020 jerry. All rights reserved.
//
import UIKit

final class ReposWireframe: ReposWireframeType {
    static func createReposModule() -> UIViewController {
        let view: ReposViewType = ReposViewController()
        let presenter: ReposPresenterType & ReposInteractorOutputsType = ReposPresenter()
        let interactor: ReposInteractorInputsType = ReposInteractor()
        let wireframe: ReposWireframeType = ReposWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let view = view as? ReposViewController {
            return UINavigationController(rootViewController: view)
        } else {
            return UIViewController()
        }
    }
}
