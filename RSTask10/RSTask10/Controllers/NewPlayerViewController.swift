//
//  NewPlayerViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class NewPlayerViewController: UIViewController {

    var viewModel: NewPlayerViewModel!
    let headerLabel: UILabel = UILabel()
    
    let textField: PlayerTextField = PlayerTextField(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        configureViewModel()
        textField.addTarget(self, action: #selector(shouldEnableButton), for: .editingChanged)
    }
    
    var additionHandler: ((String) -> Void)?
    
    func configureUI() {
        
        view.addSubview(textField)
        view.addSubview(headerLabel)
        
        navigationItem.largeTitleDisplayMode = .never
        
        headerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36.0)
        headerLabel.text = "Add Player"
        headerLabel.textColor =  UIColor.white
        
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action:  #selector(addUser))
        navigationItem.rightBarButtonItem?.isEnabled = false
        

        view.backgroundColor = UIColor(named: "AppBackground")
        
        textField.tintColor = .white
        textField.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        textField.attributedPlaceholder = NSAttributedString(string: "Player Name", attributes: [.foregroundColor: UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 0.5)])
        textField.backgroundColor = UIColor(named: "AppGrey")
        textField.textColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.0)
    }
    
    func configureLayout()  {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            headerLabel.heightAnchor.constraint(equalToConstant: Constants.headerLabelHeight),
            textField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Constants.textFieldTopOffset),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }
    
    func configureViewModel(){
        viewModel.onAlert = {[unowned self] alert in
            let alertController = UIAlertController(title: "Attention!", message: alert, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @objc func addUser(){
        if let text = textField.text{
            viewModel.add(name: text)
        }
    }
    
    @objc func shouldEnableButton(){
        navigationItem.rightBarButtonItem?.isEnabled = !(textField.text?.isEmpty ?? true)
    }
    
    @objc func goBack(){
        viewModel.goBack()
    }
}

extension NewPlayerViewController{
    enum Constants {
        static let leadingOffset: CGFloat = 20.0
        static let headerLabelHeight: CGFloat = 42.0
        static let textFieldTopOffset: CGFloat = 5.0
        static let textFieldHeight: CGFloat = 60.0
    }
}
