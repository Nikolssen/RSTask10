//
//  ShadowedButton.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

class ShadowedButton: UIButton {

    override var buttonType: UIButton.ButtonType {
        get{.custom}
    }
    var isShadowed: Bool = false {
        willSet{
            layer.shadowRadius = 0
            layer.shadowOpacity = 0.5
            layer.shadowColor = UIColor(red: 0.33, green: 0.47, blue: 0.68, alpha: 1.0).cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5.0)
        }
    }
    private var path: UIBezierPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureUI(){
        layer.masksToBounds = false
        titleLabel?.layer.masksToBounds = false
        
        backgroundColor = UIColor(named: "AppJade")
        
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        
        titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleLabel?.layer.shadowColor = UIColor(red: 0.33, green: 0.47, blue: 0.68, alpha: 1.0).cgColor
        titleLabel?.layer.shadowOpacity = 0.5
        titleLabel?.layer.shadowRadius = 0
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height/2)
        self.path = path
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return path?.contains(point) ?? false
    }
    
}
