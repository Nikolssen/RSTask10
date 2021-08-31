//
//  DashboardViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class DashboardViewController: UIViewController {
    
    let startButton: ShadowedButton = ShadowedButton(frame: .zero)
    let tableView: UITableView = UITableView(frame: .zero, style: .plain)
    var tableViewHeightConstraint: NSLayoutConstraint!
    
    let headerLabel: UILabel = UILabel()
    var viewModel: DashboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        configureViewModel()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.id)
        
    }
    
    func configureUI() {
        
        tableView.layer.cornerRadius = 15
        
        view.addSubview(startButton)
        view.addSubview(tableView)
        view.addSubview(headerLabel)
        
        tableView.backgroundColor = UIColor(named: "AppGrey")
        view.backgroundColor = UIColor(named: "AppBackground")
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false
        
        
        startButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        startButton.setTitle("Start game", for: .normal)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        startButton.isShadowed = true
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        tableView.allowsSelection = false
        
        headerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36.0)
        headerLabel.text = "Game Counter"
        headerLabel.textColor =  UIColor.white
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController, rootViewController !== navigationController {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        }
    }
    
    
    func configureLayout(){
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewHeightConstraint =  tableView.heightAnchor.constraint(equalToConstant: 110)
        NSLayoutConstraint.activate([
            
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.startButtonBottomOffset),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: Constants.startButtonHeight),
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Constants.tableViewTopOffset),
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            tableViewHeightConstraint,
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            headerLabel.heightAnchor.constraint(equalToConstant: Constants.headerLabelHeight)
        ])
    }
    
    func configureViewModel(){
        viewModel.onPlayerAdd = {[unowned self] in
            self.tableView.reloadData()
            let maximumHeight = view.safeAreaLayoutGuide.layoutFrame.height - Constants.tableViewOffsetLimit
            self.tableViewHeightConstraint.constant = min(maximumHeight, Constants.cellHeight * CGFloat(viewModel.players.count + 2))
        }
        
        viewModel.onPlayerDelete = {[unowned self] index in
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            let maximumHeight = view.safeAreaLayoutGuide.layoutFrame.height - Constants.tableViewOffsetLimit
            self.tableViewHeightConstraint.constant = min(maximumHeight, Constants.cellHeight * CGFloat(viewModel.players.count + 2))
            self.tableView.reloadData()
        }
    }
    
    @objc func start(){
        let rollViewController = RollViewController()
        
        self.addChild(rollViewController)
        view.addSubview(rollViewController.view)
        rollViewController.didMove(toParent: self)
    }
    
    
    @objc func dismissView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.players.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.id) as! UserCell
        
        if indexPath.row == viewModel.players.count{
            cell.style = .add
            cell.handler = {[unowned self] in
                self.viewModel.addPlayer()
            }
        }
        
        else {
            
            cell.style = .user
            cell.textLabel?.text = viewModel.players[indexPath.row].name
            cell.handler = { [unowned self, indexPath] in
                self.viewModel.deletePlayer(at: indexPath.row)
            }
        }
        cell.backgroundColor = UIColor(named: "AppGrey")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: Constants.cellHeight))
        view.backgroundColor = UIColor(named: "AppGrey")
        
        let label = UILabel(frame: .zero)
        label.text = "Players"
        label.font = UIFont(name: "Nunito-SemiBold", size: 16)
        label.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
}

extension DashboardViewController{
    
    enum Constants{
        static let cellHeight: CGFloat = 55.0
        static let startButtonHeight: CGFloat = 65.0
        static let startButtonBottomOffset: CGFloat = 65.0
        static let headerLabelHeight: CGFloat = 42.0
        static let tableViewTopOffset: CGFloat = 25.0
        static let tableViewOffsetLimit: CGFloat = headerLabelHeight + startButtonHeight + startButtonBottomOffset + tableViewTopOffset + 20.0
        static let leadingOffset: CGFloat = 20.0
    }
}
