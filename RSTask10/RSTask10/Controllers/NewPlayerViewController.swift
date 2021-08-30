//
//  NewPlayerViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class NewPlayerViewController: UIViewController {

    var viewModel: NewPlayerViewModel!
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Add Player"
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        navigationItem.backButtonTitle = "Back"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action:  #selector(addUser))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        
        
        view.addSubview(textField)
        
        view.backgroundColor = UIColor(named: "AppBackground")
        
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
    
    func configureViewModel(){
        viewModel.onAllert = {[unowned self] allert in
            let allertController = UIAlertController(title: "Attention!", message: allert, preferredStyle: .actionSheet)
            self.present(allertController, animated: true, completion: nil)
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
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shouldEnableButton(){
        navigationItem.rightBarButtonItem?.isEnabled = !(textField.text?.isEmpty ?? true)
    }
    
    @objc func goBack(){
        
        navigationController?.popViewController(animated: true)
    }
}
