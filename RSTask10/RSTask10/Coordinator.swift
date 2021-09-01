//
//  Coordinator.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/30/21.
//

import Foundation
import UIKit

class Coordinator {
    enum State{
        case initial
        case games
    }
    
    let window: UIWindow
    let rootViewController: UINavigationController
    var modalNavigationController: UINavigationController?
    
    var state: Coordinator.State = .initial

    
    let statusService = StatusService()
    
    func start(){
        rootViewController.setViewControllers([dashboardViewController], animated: true)
    }
    
    var dashboardViewController: DashboardViewController{
        let dashboardViewController = DashboardViewController()
        let dashboardViewModel = DashboardViewModel(coordinator: self)
        dashboardViewController.viewModel = dashboardViewModel
        return dashboardViewController
    }
    
    var newPlayerViewController: NewPlayerViewController{
        let newPlayerViewController = NewPlayerViewController()
        let newPlayerViewModel = NewPlayerViewModel(coordinator: self)
        newPlayerViewController.viewModel = newPlayerViewModel
        return newPlayerViewController
    }
    
    var gameViewController: GameViewController{
        let gameViewController = GameViewController()
        return gameViewController
    }
    
    init(window: UIWindow){
        self.window = window
        rootViewController = UINavigationController()
        window.rootViewController = rootViewController
    }
    
}

extension Coordinator: DashboardViewModelCoordinator{
    func startGame(with players: [Player]) {
        let gameViewController = self.gameViewController
        gameViewController.viewModel = GameViewModel(players: players, coordinator: self)
        rootViewController.setViewControllers([gameViewController], animated: true)
        if let modalNavigationController = modalNavigationController {
            modalNavigationController.dismiss(animated: true, completion: nil)
            self.modalNavigationController = nil
        }
        
    }
    
    func addPlayer(handler: @escaping ((String) -> Bool)) {
        let newPlayerViewController = self.newPlayerViewController
        newPlayerViewController.viewModel.onPlayerAdd = handler
        if let modalNavigationController = modalNavigationController {
            modalNavigationController.pushViewController(newPlayerViewController, animated: true)
        }
        else {
            rootViewController.pushViewController(newPlayerViewController, animated: true)
        }
    }
}

extension Coordinator: NewPlayerViewModelCoordinator{
    func dismiss() {
        if let modalNavigationController = modalNavigationController {
            modalNavigationController.popViewController(animated: true)
        }
        else {
            rootViewController.popViewController(animated: true)
        }
    }
}

extension Coordinator: GameViewModelCoordinator{
    func showResults(players: [Player], turns: [Turn]) {
        let resultViewController = ResultViewController()
        let resultViewModel = ResultsViewModel(coordinator: self, players: players, turns: turns)
        resultViewController.viewModel = resultViewModel
        rootViewController.pushViewController(resultViewController, animated: true)
    }
    
    func newGame() {
        let dashboardViewController = self.dashboardViewController
        let modalNavigationController = UINavigationController(rootViewController: dashboardViewController)
        self.modalNavigationController = modalNavigationController
        rootViewController.present(modalNavigationController, animated: true, completion: nil)
    }
    
    
}

extension Coordinator: ResultsViewModelCoordinator{
    func newGameFromResults() {
        
    }
    
    func resume() {
        rootViewController.popViewController(animated: true)
    }
    
    
}
