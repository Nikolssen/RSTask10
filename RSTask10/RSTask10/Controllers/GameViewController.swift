//
//  GameViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class GameViewController: UIViewController {

    let collectionView = UICollectionView()
    let topLabel = UILabel()
    let diceButton = UIButton()
    let timerLabel = UILabel()
    let playButton = UIButton()
    
    let buttons: [ShadowedButton] = [.init(), .init(), .init(), .init(), .init()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        diceButton.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topLabel)
        view.addSubview(collectionView)
        view.addSubview(diceButton)
        view.addSubview(timerLabel)
        view.addSubview(playButton)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttons.forEach {
            stackView.addArrangedSubview($0)
            $0.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        buttons[0].setTitle("-10", for: .normal)
        buttons[1].setTitle("-5", for: .normal)
        buttons[2].setTitle("-1", for: .normal)
        buttons[3].setTitle("+5", for: .normal)
        buttons[4].setTitle("+10", for: .normal)
        
        diceButton.setImage(UIImage(named: "Four"), for: .normal)
        
    }
}
