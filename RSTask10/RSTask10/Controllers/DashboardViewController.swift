//
//  DashboardViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class DashboardViewController: UIViewController {

    var startButton: ShadowedButton!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        
    }
    
    func configureUI() {
        
        
        if #available(iOS 13, *){
            tableView = UITableView(frame: .zero, style: .insetGrouped)
        } else {
            tableView = UITableView(frame: .zero, style: .grouped)
            tableView.layer.cornerRadius = 15
        }
        
        startButton = ShadowedButton(frame: .zero)
        
        view.addSubview(startButton)
        view.addSubview(tableView)
        
        view.backgroundColor = .init(named: "AppBackground")
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Game Counter"
        
        startButton.setTitle("Start game", for: .normal)
        
    }
    
    
    func configureLayout(){
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 65),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: startButton.topAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        if #available(iOS 13, *){
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        } else {
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        }
    }
}
