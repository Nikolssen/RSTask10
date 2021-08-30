//
//  DashboardViewModel.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/30/21.
//

import Foundation

protocol DashboardViewModelCoordinator {
    
    func startGame(with players: [Player])
    func addPlayer(handler: @escaping ((String)->Bool))
}

class DashboardViewModel {
    
    var players: [Player] = .init()
    let coordinator: DashboardViewModelCoordinator
    
    var onPlayerDelete: ((Int) -> Void)?
    var onPlayerAdd: (() -> Void)?
    
    func startGame(){
        coordinator.startGame(with: players)
    }
    
    func addPlayer(){
        coordinator.addPlayer {[unowned self] name in
            if self.players.contains(where: {$0.name == name}) {
                return false
            }
            else
            {
                self.players.append(Player(name: name))
                self.onPlayerAdd?()
                return true
            }
        }
    }
    
    init(coordinator: DashboardViewModelCoordinator){
        self.coordinator = coordinator
    }
    
}
