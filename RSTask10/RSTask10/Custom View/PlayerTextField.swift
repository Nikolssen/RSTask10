//
//  PlayerTextField.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

class PlayerTextField: UITextField {

    private let edgeInsets = UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 24)
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
}
