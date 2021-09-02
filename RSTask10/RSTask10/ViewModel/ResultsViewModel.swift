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
        self.turns = turns.reversed()
    }
    
    func newGame(){
        coordinator.newGameFromResults()
    }
    func resume(){
        coordinator.resume()
    }
    
    func scoreRanking() -> [(Player, Int)]{
        let players = players.sorted {
            if $0.score > $1.score {
                return true
            }
            if $0.score == $1.score, $0.name < $1.name {
                return true
            }
            return false
        }
        return Array(zip(players, players.indices.map({$0.advanced(by: 1)})))
    }
}
