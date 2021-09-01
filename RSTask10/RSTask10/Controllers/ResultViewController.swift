//
//  ResultViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class ResultViewController: UIViewController {
    
    var viewModel: ResultsViewModel!
    
    let scrollView = UIScrollView()
    let headerLabel = UILabel()
    
    
    let leaderStack = UIStackView()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "AppBackground")
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Resume", style: .plain, target: self, action:  #selector(resume))
        
        headerLabel.text = "Game"
        headerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36.0)
        headerLabel.textColor =  UIColor.white
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.horizontalOffset),
            headerLabel.heightAnchor.constraint(equalToConstant: Constants.headerLabelHeight),
        ])
    }
    
    
    
    
    @objc func newGame() {
        viewModel.newGame()
    }
    
    @objc
    func resume() {
        viewModel.resume()
    }
    
}

extension ResultViewController{
    enum Constants{
        static let headerLabelHeight: CGFloat = 42
        static let horizontalOffset: CGFloat = 20
    }
}
