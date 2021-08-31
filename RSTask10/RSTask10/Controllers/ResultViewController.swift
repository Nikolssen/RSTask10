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
    let headerTitle = UILabel()
    
    
    let leaderStack = UIStackView()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "AppBackground")
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Resume", style: .plain, target: self, action:  #selector(resume))
        
    }
    
    
    
    @objc func newGame() {
        viewModel.newGame()
    }
    
    @objc
    func resume() {
        viewModel.resume()
    }
    
}
