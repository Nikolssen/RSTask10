//
//  ResultsViewModel.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/30/21.
//

import Foundation
protocol ResultsViewModelCoordinator{
    func newGameFromResults()
    func resume()
}

class ResultsViewModel {
    var players: [Player]
    var turns: [Turn]
    let coordinator: ResultsViewModelCoordinator
    
    init(coordinator: ResultsViewModelCoordinator, players: [Player], turns: [Turn]){
        self.coordinator = coordinator
        self.players = players
        self.turns = turns
    }
    
    func newGame(){
        coordinator.newGameFromResults()
    }
    func resume(){
        coordinator.resume()
    }
}
