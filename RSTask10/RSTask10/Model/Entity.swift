//
//  Entity.swift
//  RSTask10
//
//  Created by Ivan Budovich on 9/2/21.
//

import Foundation

struct Entity: Codable {
    
    let players: [Player]
    let turns: [Turn]
    let timestamp: TimeInterval?
    let stoppedTime: TimeInterval?
    let currentIndex: Int
}
