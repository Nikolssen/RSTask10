//
//  GameViewModel.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/30/21.
//

import Foundation
protocol GameViewModelCoordinator {
    func showResults(players: [Player], turns: [Turn])
    func newGame()
}

class GameViewModel {
    
    var currentPlayerIndex: Int {
        willSet{
            turns.append(Turn(player: players[newValue].name, scoreChange: 0))
            onNewTurn?()
        }
    }
    var players: [Player]
    var turns: [Turn] = .init()
    let coordinator: GameViewModelCoordinator
    
    var onNewTurn: (()-> Void)?
    
    init(players: [Player], coordinator: GameViewModelCoordinator) {
        self.players = players
        self.coordinator = coordinator
        currentPlayerIndex = 0
        turns.append(Turn(player: players[0].name, scoreChange: 0))
    }
    
    func add(score: Int){
        if score < 0 {
            let absScore = abs(score)
            if absScore <= players[currentPlayerIndex].score{
                players[currentPlayerIndex].score -= absScore
            }
        }
        else {
            players[currentPlayerIndex].score += score
        }
        turns[turns.count - 1].scoreChange += score
    }
    
    func resetTurn(){
        players[currentPlayerIndex].score -= turns[turns.count - 1].scoreChange
        turns[turns.count - 1].scoreChange = 0
    }
    
    func showResults(){
        coordinator.showResults(players: players, turns: turns)
    }
    
    func newGame(){
        coordinator.newGame()
    }
    
}
