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
            onNewTurn?(newValue)
        }
    }
    var players: [Player]
    var turns: [Turn] = .init()
    let coordinator: GameViewModelCoordinator
    
    let startTime: TimeInterval?
    let stopTime: TimeInterval?
    
    let statusService: StatusService
    var onNewTurn: ((Int)-> Void)?
    
    init(players: [Player], coordinator: GameViewModelCoordinator, statusService: StatusService) {
        self.players = players
        self.coordinator = coordinator
        self.currentPlayerIndex = 0
        turns.append(Turn(player: players[0].name, scoreChange: 0))
        
        self.startTime = nil
        self.stopTime = nil
        self.statusService = statusService
    }
    
    init(entity: Entity, coordinator: GameViewModelCoordinator, statusService: StatusService) {
        self.players = entity.players
        self.coordinator = coordinator
        self.turns = entity.turns
        self.startTime = entity.timestamp
        self.stopTime = entity.stoppedTime
        self.currentPlayerIndex = entity.currentIndex
        self.statusService = statusService
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
    
    func getTimerRestoreInfo() -> (startTime: TimeInterval?, stopTime: TimeInterval?)?{
        guard  startTime != nil || stopTime != nil else { return nil }
        return (startTime, stopTime)
    }
    
    func saveParty(timestamp: TimeInterval?, stoppedTime: TimeInterval?){
        statusService.store(entity: Entity(players: players, turns: turns, timestamp: timestamp, stoppedTime: stoppedTime, currentIndex: currentPlayerIndex))
    }
    
    func clearParty(){
        statusService.clearEntity()
    }
    
    
}
