//
//  CarouselCell.swift
//  RSTask10
//
//  Created by Admin on 29.08.2021.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    static let id = "CarouselID"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        label.textColor = UIColor(named: "AppOrange")
        
        return label
    }()
    
    let scoreLabel: UILabel = {
       
        let label = UILabel()
        label.font = UIFont(name: "Nunito-Bold", size: 100)
        label.textColor = UIColor(red: 1, green: 0.99, blue: 0.99, alpha: 1.0)
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/14),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
