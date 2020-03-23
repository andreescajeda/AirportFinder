//
//  TabBarController.swift
//  AirportFinder
//
//  Created by André Escajeda Ríos on 22/03/20.
//  Copyright © 2020 André Escajeda Ríos. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var airports: [Airport]
    
    init(_ nibName: String?, _ bundle: Bundle?, _ airports: [Airport]) {
        self.airports = airports
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        view.backgroundColor = .background
        
        tabBar.barTintColor = .background
        tabBar.isTranslucent = true
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor(white: 1, alpha: 1)
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let mapController = MapController()
        mapController.airports = airports
        
        let mapNavigationController = UINavigationController(rootViewController: mapController)
        mapNavigationController.tabBarItem.image = UIImage(named: "round_location_on_white_36pt")
        mapNavigationController.tabBarItem.selectedImage = UIImage(named: "round_location_on_black_36pt")
        mapNavigationController.tabBarItem.title = "Mapa"
        
        let listController = ListController()
        listController.airports = airports
        
        let listNavigationController = UINavigationController(rootViewController: listController)
        listNavigationController.tabBarItem.image = UIImage(named: "round_format_list_bulleted_white_36pt")
        listNavigationController.tabBarItem.selectedImage = UIImage(named: "round_format_list_bulleted_black_36pt")
        listNavigationController.tabBarItem.title = "Lista"
        
        let closeNavigationController = UINavigationController(rootViewController: UIViewController())
        closeNavigationController.tabBarItem.image = UIImage(named: "round_close_white_36pt")
        closeNavigationController.tabBarItem.selectedImage = UIImage(named: "round_close_black_36pt")
        closeNavigationController.tabBarItem.title = "Cerrar"
        
        viewControllers = [mapNavigationController, listNavigationController, closeNavigationController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if (viewController == tabBarController.viewControllers?[2]){
            dismiss(animated: true)
        }
        
        return true
    }
}
