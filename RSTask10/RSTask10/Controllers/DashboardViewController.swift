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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dashboardID")
        
    }
    
    func configureUI() {
        
        tableView.layer.cornerRadius = 15
        
        view.addSubview(startButton)
        view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor(named: "AppGrey")
        view.backgroundColor = UIColor(named: "AppBackground")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Game Counter"
        
        startButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        startButton.setTitle("Start game", for: .normal)
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
     
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        tableView.allowsSelection = false
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        

    }
    
    
    func configureLayout(){
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableViewHeightConstraint =  tableView.heightAnchor.constraint(equalToConstant: 110)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 65),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: startButton.topAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
           
        ])
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // tableViewHeightConstraint.constant =
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
        dismiss(animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardID")!
        if indexPath.row == users.count{
            cell.textLabel?.font = UIFont(name: "Nunito-SemiBold", size: 16)
            cell.textLabel?.text = "Add player"
            cell.textLabel?.textColor = UIColor(named: "AppJade")
            cell.imageView?.image = UIImage(named: "Add")

        }
        
        else {
            
            cell.imageView?.image = UIImage(named: "Delete")
            cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
            cell.textLabel?.text = users[indexPath.row]
            cell.textLabel?.textColor = UIColor.white
            cell.imageView?.image = UIImage(named: "Delete")
            
            
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
