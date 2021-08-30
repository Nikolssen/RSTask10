//
//  GameViewModel.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/30/21.
//

import Foundation
protocol GameViewModelCoordinator {
    func showResults()
    func newGame()
}

class GameViewModel {
    
    var currentPlayerIndex: Int = 0
    var players: [Player]
    let coordinator: GameViewModelCoordinator
    
    init(players: [Player], coordinator: GameViewModelCoordinator) {
        self.players = players
        self.coordinator = coordinator
    }
    
    func add(score: Int){
        if score < 0 {
            let absScore = abs(score)
            if absScore <= players[currentPlayerIndex].score{
                players[currentPlayerIndex].score -= UInt64(absScore)
            }
        }
        else {
            players[currentPlayerIndex].score += UInt64(score)
        }
    }
    
}
