//
//  NewPlayerViewModel.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/30/21.
//

import Foundation
protocol NewPlayerViewModelCoordinator {
    func dismiss()
}

class NewPlayerViewModel {
    let coordinator: NewPlayerViewModelCoordinator
    
    var onPlayerAdd: ((String) -> Bool)?
    var onAlert: ((String) -> Void)?
    
    init(coordinator: NewPlayerViewModelCoordinator){
        self.coordinator = coordinator
    }
    
    func add(name: String){
        
        guard let onPlayerAdd = onPlayerAdd else {return}

        if onPlayerAdd(name) {
            coordinator.dismiss()
            
        } else {
            onAlert?("The player with name \"\(name)\" already exists!")
        }
    }
    
    func goBack(){
        coordinator.dismiss()
    }
    
    
    
}
