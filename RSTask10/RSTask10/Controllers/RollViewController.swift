//
//  RollViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit
import AudioToolbox

final class RollViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dismissView)))
        
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        let imageView = UIImageView()
        
        
        view.addSubview(imageView)
        view.addSubview(visualEffectView)
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            visualEffectView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
}
