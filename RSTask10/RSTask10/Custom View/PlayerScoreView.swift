//
//  PlayerScoreView.swift
//  RSTask10
//
//  Created by Ivan Budovich on 9/1/21.
//

import UIKit

class PlayerScoreView: UIView {

    var placeLabel = UILabel()
    var nameLabel  = UILabel()
    var scoreLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupFromPlayer(player: Player, place: Int) {
        self.placeLabel.text = "#\(place) "
        self.nameLabel.text = player.name
        self.scoreLabel.text = "\(player.score)"
    }
    
    func commonInit() {
        
        addSubview(placeLabel)
        addSubview(nameLabel)
        addSubview(scoreLabel)
        
        placeLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        placeLabel.textColor = .white
        
        nameLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        nameLabel.textColor = UIColor(named: "AppOrange")
        
        scoreLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        scoreLabel.textColor = .white
        
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeLabel.leftAnchor.constraint(equalTo: leftAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: placeLabel.rightAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

}

