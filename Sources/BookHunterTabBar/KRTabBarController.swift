//
//  BookHunterTabBarController.swift
//  BookHunterTabBarController
//
//  Created by Kerolles Roshdi on 2/14/20.
//  Copyright © 2020 Kerolles Roshdi. All rights reserved.
//

import UIKit

class BookHunterTabBarController: UITabBarController {
    
    @IBInspectable
    var iconsColor: UIColor?
    @IBInspectable
    var middleButtonImage: UIImage?
    @IBInspectable
    var closeButtonImage: UIImage?
    
    private var buttons = [UIButton]()
    
    private var customTabBarViewBottomAnchor: NSLayoutConstraint!
    private var middleButtonBottomAnchor: NSLayoutConstraint!
    
    private var button2CenterYAnchor: NSLayoutConstraint!
    private var button2CenterXAnchor: NSLayoutConstraint!
    
    private var button3centerYAnchor: NSLayoutConstraint!
    
    private var button4CenterYAnchor: NSLayoutConstraint!
    private var button4CenterXAnchor: NSLayoutConstraint!
    
    private let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: -15)
        view.layer.shadowRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let middleButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.addTarget(self, action: #selector(didSelectMiddleButton(sender:)), for: .touchUpInside)
        button.backgroundColor = .red
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
                stackView.spacing = 100
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override var viewControllers: [UIViewController]? {
        didSet {
            createButtonsStack(viewControllers!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        checkVariables()
        createButtonsStack(viewControllers!)
        addCustomTabBarView()
        middleButton.setImage(middleButtonImage, for: .normal)
        middleButton.backgroundColor = iconsColor
        configure3Buttons()
        autolayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabBarView.layer.cornerRadius = customTabBarView.frame.size.height / 2.5
        middleButton.layer.cornerRadius = middleButton.frame.size.width / 2.095
        
        for index in 2..<buttons.count {
            buttons[index].layer.cornerRadius = buttons[index].frame.size.width / 2
        }
        
    }
    
    private func checkVariables() {
        guard iconsColor != nil else { fatalError("please select a color for icons in storyboard inspectables") }
        guard middleButtonImage != nil else { fatalError("please select an image for the middle button in storyboard inspectables") }
        guard closeButtonImage != nil else { fatalError("please select an image for the close button in storyboard inspectables") }
        guard viewControllers?.count == 5 else { fatalError("please add exactly five(5) UIviewControllers to the TabBar") }
    }
    
    private func createButtonsStack(_ viewControllers: [UIViewController]) {
        
        // clean :
        buttons.removeAll()
        
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for (index, viewController) in viewControllers.enumerated() {
            
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(didSelectIndex(sender:)), for: .touchUpInside)
            button.setImage(viewController.tabBarItem.image, for: .normal)
            button.imageView?.tintColor = .black

            if index == 0 {
                button.imageView?.tintColor = iconsColor
            }
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            buttons.append(button)
        }
        
        stackView.addArrangedSubview(buttons[0])
        stackView.addArrangedSubview(buttons[1])
        
        view.setNeedsLayout()
    }
    
    private func configure3Buttons() {
        for index in 2..<buttons.count {
            buttons[index].backgroundColor = .white
            buttons[index].layer.cornerRadius = 40
            buttons[index].layer.shadowColor = UIColor.black.cgColor
            buttons[index].layer.shadowOpacity = 0.05
            buttons[index].layer.shadowOffset = CGSize(width: 0, height: 15)
            buttons[index].layer.shadowRadius = 15
        }
    }
    
    private func autolayout() {
        NSLayoutConstraint.activate([
            customTabBarView.widthAnchor.constraint(equalTo: tabBar.widthAnchor),
            customTabBarView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, constant: 20),
            customTabBarView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: 10),
            
            middleButton.widthAnchor.constraint(equalToConstant: tabBar.bounds.size.width / 4.5),
            middleButton.heightAnchor.constraint(equalTo: customTabBarView.heightAnchor, constant: 50),
            middleButton.centerXAnchor.constraint(equalTo: customTabBarView.centerXAnchor),
            
            
            buttons[2].widthAnchor.constraint(equalTo: middleButton.widthAnchor, constant: -15),
            buttons[2].heightAnchor.constraint(equalTo: buttons[2].widthAnchor),
            
            buttons[3].widthAnchor.constraint(equalTo: middleButton.widthAnchor, constant: -15),
            buttons[3].heightAnchor.constraint(equalTo: buttons[3].widthAnchor),
            buttons[3].centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            
            buttons[4].widthAnchor.constraint(equalTo: middleButton.widthAnchor, constant: -15),
            buttons[4].heightAnchor.constraint(equalTo: buttons[4].widthAnchor),

            
         ])
        
        customTabBarViewBottomAnchor = customTabBarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        customTabBarViewBottomAnchor.isActive = true
        
        middleButtonBottomAnchor = middleButton.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -5)
        middleButtonBottomAnchor.isActive = true
        
        
        button2CenterYAnchor = buttons[2].centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        button2CenterYAnchor.isActive = true
        button2CenterXAnchor = buttons[2].centerXAnchor.constraint(equalTo: middleButton.centerXAnchor)
        button2CenterXAnchor.isActive = true
        
        
        button3centerYAnchor = buttons[3].centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        button3centerYAnchor.isActive = true
        
        button4CenterYAnchor = buttons[4].centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        button4CenterYAnchor.isActive = true
        button4CenterXAnchor = buttons[4].centerXAnchor.constraint(equalTo: middleButton.centerXAnchor)
        button4CenterXAnchor.isActive = true
        
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        
        customTabBarView.addSubview(stackView)
        
        view.addSubview(buttons[2])
        view.addSubview(buttons[3])
        view.addSubview(buttons[4])
        
        view.addSubview(middleButton)
    }
    
    @objc private func didSelectIndex(sender: UIButton) {
        let index = sender.tag
        self.selectedIndex = index
        
        
        UIView.animate(withDuration: 0.1, animations: {
            for (indx, button) in self.buttons.enumerated() {
                if indx != index {
                    button.imageView?.tintColor = .black
                } else {
                    button.imageView?.tintColor = self.iconsColor
                }
            }
            
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            if index > 1 {
                sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }) { _ in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveLinear, .allowUserInteraction], animations: {
                sender.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        
    }
    
    
    @objc private func didSelectMiddleButton(sender: UIButton) {
        
        let isClosed = sender.tag == 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            
            self.middleButtonBottomAnchor.isActive = false
            self.middleButtonBottomAnchor = self.middleButton.bottomAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: isClosed ? -45 : -5)
            self.middleButtonBottomAnchor.isActive = true
            
            self.button2CenterYAnchor.isActive = false
            self.button2CenterYAnchor = isClosed ? self.buttons[2].centerYAnchor.constraint(equalTo: self.middleButton.topAnchor, constant: 30) : self.buttons[2].centerYAnchor.constraint(equalTo: self.middleButton.centerYAnchor)
            self.button2CenterYAnchor.isActive = true
           
            self.button2CenterXAnchor.isActive = false
            self.button2CenterXAnchor = isClosed ? self.buttons[2].centerXAnchor.constraint(equalTo: self.middleButton.leadingAnchor, constant: -60) : self.buttons[2].centerXAnchor.constraint(equalTo: self.middleButton.centerXAnchor)
            self.button2CenterXAnchor.isActive = true
            
            
            self.button3centerYAnchor.isActive = false
            self.button3centerYAnchor = isClosed ? self.buttons[3].centerYAnchor.constraint(equalTo: self.middleButton.topAnchor, constant: -60) : self.buttons[3].centerYAnchor.constraint(equalTo: self.middleButton.centerYAnchor)
            self.button3centerYAnchor.isActive = true
            
            
            self.button4CenterYAnchor.isActive = false
            self.button4CenterYAnchor = isClosed ? self.buttons[4].centerYAnchor.constraint(equalTo: self.middleButton.topAnchor, constant: 30) : self.buttons[4].centerYAnchor.constraint(equalTo: self.middleButton.centerYAnchor)
            self.button4CenterYAnchor.isActive = true
            
            self.button4CenterXAnchor.isActive = false
            self.button4CenterXAnchor = isClosed ? self.buttons[4].centerXAnchor.constraint(equalTo: self.middleButton.trailingAnchor, constant: 60) : self.buttons[4].centerXAnchor.constraint(equalTo: self.middleButton.centerXAnchor)
            self.button4CenterXAnchor.isActive = true
            
            self.customTabBarViewBottomAnchor.isActive = false
            self.customTabBarViewBottomAnchor = self.customTabBarView.bottomAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: isClosed ? self.customTabBarView.bounds.height - 20 : 0)
            self.customTabBarViewBottomAnchor.isActive = true
            
            sender.setImage(isClosed ? self.closeButtonImage : self.middleButtonImage, for: .normal)
            sender.tag = isClosed ? 1 : 0
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    
}

extension BookHunterTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard
            let items = tabBar.items,
            let index = items.firstIndex(of: item)
            else {
                print("not found")
                return
        }
        didSelectIndex(sender: self.buttons[index])
    }
}

