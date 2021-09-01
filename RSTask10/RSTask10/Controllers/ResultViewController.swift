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
        confugureUI()
        configureLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ResultCell.self, forCellReuseIdentifier: "TurnID")
        
    }
    
    func confugureUI() {
        view.addSubview(headerLabel)
        view.addSubview(tableView)
        view.addSubview(scrollView)
        

        view.backgroundColor = UIColor(named: "AppBackground")
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Resume", style: .plain, target: self, action:  #selector(resume))
        
        headerLabel.text = "Results"
        headerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36.0)
        headerLabel.textColor =  UIColor.white
        scrollView.backgroundColor = .gray
        tableView.layer.cornerRadius = 15
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(named: "AppGrey")
    }
    
    func configureLayout(){
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewHeight = view.safeAreaLayoutGuide.layoutFrame.height
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.horizontalOffset),
            headerLabel.heightAnchor.constraint(equalToConstant: Constants.headerLabelHeight),
            
            scrollView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: viewHeight * Constants.spacingRatio),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.horizontalOffset),
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: viewHeight * Constants.scrollViewRatio),
            
            tableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: viewHeight * Constants.spacingRatio),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.horizontalOffset),
            tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.spacingRatio * viewHeight)
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

extension ResultViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TurnID")!
        cell.backgroundColor = UIColor(named: "AppGrey")
    
        cell.textLabel?.text = viewModel.turns[indexPath.row].player
        cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        cell.textLabel?.textColor = .white
        //cell.detailTextLabel.
        let rightLabel = cell.detailTextLabel!
        rightLabel.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        rightLabel.textColor = .white
        rightLabel.sizeToFit()
        cell.accessoryView = rightLabel
        let score = viewModel.turns[indexPath.row].scoreChange
        let string = score > 0 ? "+\(score)" : "\(score)"
        rightLabel.text = string
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.turns.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: Constants.cellHeight))
        view.backgroundColor = UIColor(named: "AppGrey")
        
        let label = UILabel(frame: .zero)
        label.text = "Turns"
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

extension ResultViewController{
    enum Constants{
        static let headerLabelHeight: CGFloat = 42
        static let horizontalOffset: CGFloat = 20
        static let tableViewRatio: CGFloat = 0.6
        static let scrollViewRatio: CGFloat = 0.25
        static let spacingRatio: CGFloat = 0.033
        static let cellHeight: CGFloat = 55.0
    }
}
