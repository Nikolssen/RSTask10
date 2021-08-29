//
//  UserCell.swift
//  RSTask10
//
//  Created by Admin on 29.08.2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    enum Style{
        case user
        case add
    }
    
    static let id = "dashboardID"
    
    var handler: (() -> (Void))?
    
    var style: UserCell.Style = .user {
        willSet{
            if newValue == .user {
                imageView?.image = UIImage(named: "Delete")
                textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
                textLabel?.textColor = UIColor.white
            }
            else {
                imageView?.image = UIImage(named: "Add")
                textLabel?.font = UIFont(name: "Nunito-SemiBold", size: 16)
                textLabel?.text = "Add player"
                textLabel?.textColor = UIColor(named: "AppJade")
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    @objc func imageTapped(){
        if let handler = handler {
            handler()
        }
    }
}
