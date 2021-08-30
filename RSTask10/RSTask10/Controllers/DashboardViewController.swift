//
//  DashboardViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class DashboardViewController: UIViewController {
    
    let startButton: ShadowedButton = ShadowedButton(frame: .zero)
    let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    var tableViewHeightConstraint: NSLayoutConstraint!
    var users: [String] = ["Jane", "Ryan"]
    
    let topLabel: UILabel = UILabel()
    var viewModel: DashboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.id)
        
    }
    
    func configureUI() {
        
        tableView.layer.cornerRadius = 15
        
        view.addSubview(startButton)
        view.addSubview(tableView)
        view.addSubview(topLabel)
        
        tableView.backgroundColor = UIColor(named: "AppGrey")
        view.backgroundColor = UIColor(named: "AppBackground")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = true

        
        startButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        startButton.setTitle("Start game", for: .normal)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        startButton.isShadowed = true
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        tableView.allowsSelection = false
        
        topLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36.0)
        topLabel.text = "Game Counter"
        
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController, rootViewController !== navigationController {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        }
    }
    
    
    func configureLayout(){
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewHeightConstraint =  tableView.heightAnchor.constraint(equalToConstant: 110)
        NSLayoutConstraint.activate([
            
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 65),
            tableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 25),
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableViewHeightConstraint,
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topLabel.heightAnchor.constraint(equalToConstant: 42.0)
        ])
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let maximumHeight = view.safeAreaLayoutGuide.layoutFrame.height - 65 - 65 - 20
        tableViewHeightConstraint.constant = min(maximumHeight, CGFloat(55 * (users.count + 2)))
    }
    
    @objc func start(){
        let rollViewController = RollViewController()
        
        self.addChild(rollViewController)
        view.addSubview(rollViewController.view)
        rollViewController.didMove(toParent: self)
    }
    
    @objc func add(){
        let newPlayerViewController = NewPlayerViewController()
        newPlayerViewController.additionHandler = {[unowned self] string in
            self.users.append(string)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(newPlayerViewController, animated: true)
    }
    
    @objc func dismissView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.id) as! UserCell
        if indexPath.row == users.count{
            cell.style = .add
            cell.handler = {[indexPath, unowned self] in
                self.viewModel.addPlayer()
            }
        }
        
        else {
            
            cell.style = .user
            cell.textLabel?.text = users[indexPath.row]
            cell.handler = { [unowned self] in
                
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            
        }
        cell.backgroundColor = UIColor(named: "AppGrey")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 55.0))
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
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
