//
//  ViewController.swift
//  PopToRootWithCompletion
//
//  Created by Salman Biljeek on 2/16/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let pushButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .systemBackground
            configuration.attributedTitle = AttributedString("Push to VC2", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .label
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handlePushToVC2), for: .touchUpInside)
            return button
        }()
        
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pushButton)
        pushButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pushButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    lazy var viewController2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        
        let pushButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .systemBackground
            configuration.attributedTitle = AttributedString("Push to VC3", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .label
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handlePushToVC3), for: .touchUpInside)
            return button
        }()
        
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(pushButton)
        pushButton.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pushButton.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        return vc
    }()
    
    lazy var viewController3: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        
        let pushButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var titleContainer = AttributeContainer()
            titleContainer.font = .systemFont(ofSize: 35, weight: .black)
            titleContainer.foregroundColor = .systemBackground
            configuration.attributedTitle = AttributedString("Pop to Root", attributes: titleContainer)
            var subtitleContainer = AttributeContainer()
            subtitleContainer.font = .systemFont(ofSize: 20)
            subtitleContainer.foregroundColor = .systemBackground
            configuration.attributedSubtitle = AttributedString("with completion handler", attributes: subtitleContainer)
            configuration.titleAlignment = .center
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .systemOrange
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handlePopToRoot), for: .touchUpInside)
            return button
        }()
        
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(pushButton)
        pushButton.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        //        pushButton.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        pushButton.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        return vc
    }()
    
    @objc fileprivate func handlePushToVC2() {
        self.handlePush(vc: self.viewController2)
    }
    
    @objc fileprivate func handlePushToVC3() {
        self.handlePush(vc: self.viewController3)
    }
    
    @objc fileprivate func handlePopToRoot() {
        self.navigationController?.popToRootViewController(animated: true, completion: {
            print("Did pop to root")
        })
    }
    
    @objc fileprivate func handlePush(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UINavigationController {
    func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        popToRootViewController(animated: animated)
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
