//
//  DiceView.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/31/21.
//

import UIKit

class DiceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var isHidden: Bool{
        willSet{
            if (!isHidden){
                imageView.image = images.randomElement()
            }
        }
    }
    
    let imageView: UIImageView = UIImageView()
    var images: [UIImage] = {
        ["One", "Two", "Three", "Four", "Five", "Six"].compactMap{ UIImage(named: $0) }
    }()
    
    func commonInit(){
        backgroundColor = nil
        
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        let imageView = self.imageView
       
        visualEffectView.contentView.addSubview(imageView)
        addSubview(visualEffectView)

        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffectView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.diceWidth),
            imageView.widthAnchor.constraint(equalToConstant: Constants.diceWidth)
        ])
    }
}

extension DiceView{
    enum Constants{
        static let diceWidth: CGFloat = 120.0
    }
}
