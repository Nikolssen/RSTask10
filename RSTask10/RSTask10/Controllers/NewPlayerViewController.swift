//
//  NewPlayerViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class NewPlayerViewController: UIViewController {

    let textField: PlayerTextField = PlayerTextField(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        // Do any additional setup after loading the view.
    }

    func configureUI() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Add Player"
        
        view.backgroundColor = .init(named: "AppBackground")
        
        view.addSubview(textField)
        
        
        textField.tintColor = .white
        textField.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        textField.attributedPlaceholder = NSAttributedString(string: "Player Name", attributes: [.foregroundColor: UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 0.5)])
        textField.backgroundColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0)
        textField.textColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.0)
    }
    
    func configureLayout()  {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
