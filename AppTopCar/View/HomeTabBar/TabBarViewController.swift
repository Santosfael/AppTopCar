//
//  TabBarViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 08/04/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemB
        configTabBar()
        // Do any additional setup after loading the view.
    }
    
    private func configTabBar() {
        let homeViewController = HomeViewController()
        let mapViewController = MapViewController()
        let profileViewController = ProfileViewController()
        
        homeViewController.title = "Home"
        mapViewController.title = "Map"
        profileViewController.title = "Profile"
        
        self.setViewControllers([homeViewController, mapViewController, profileViewController], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let images = ["house", "map", "person.crop.circle"]
        
        for item in 0..<items.count {
            items[item].image = UIImage(systemName: images[item])
        }
    }

}
