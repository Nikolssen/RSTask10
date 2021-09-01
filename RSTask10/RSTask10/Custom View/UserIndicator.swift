//
//  UserIndicator.swift
//  RSTask10
//
//  Created by Ivan Budovich on 9/1/21.
//

import UIKit

class UserIndicator: UIScrollView {

    let stackView = UIStackView()
    var labels: [UILabel]!
    
    var activeIndex: Int {
        set{
            if newValue >= 0 && newValue < _characters.count {
                index = newValue
            }
        }
        get{
            index
        }
    }
    private var index: Int = 0 {
        willSet{
            labels[index].textColor = UIColor(named: "AppGrey")
            labels[newValue].textColor = .white
            focus(at: newValue)
        }
    }
    var characters: [String] {
        set{
            _characters = newValue.compactMap({ !$0.isEmpty ? String($0.first!) : nil })
        }
        get { _characters }
    }
    private var _characters: [String] = .init() {
        willSet{
            stackView.subviews.forEach({ $0.removeFromSuperview() })
            labels = .init()
            for character in newValue{
                let label = UILabel(frame: .zero)
                label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
                label.textColor = UIColor(named: "AppGrey")
                label.text = character
                stackView.addArrangedSubview(label)
                labels.append(label)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        
        ])
        showsHorizontalScrollIndicator = false
        isScrollEnabled = false
    }
    
    func focus(at position: Int) {
        let scrollViewCenter = bounds.width / 2
        setContentOffset(CGPoint(x: position * 25 - Int(scrollViewCenter), y: 0), animated: true)
    }

}
