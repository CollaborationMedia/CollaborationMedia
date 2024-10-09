//
//  TabBarController.swift
//  CollaborationMedia
//
//  Created by 조규연 on 10/8/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarController()
    }
    
    func setTabBarController() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        
        let home = UINavigationController(rootViewController: TrendingViewController())
        home.tabBarItem = UITabBarItem(title: "Home", image: Image.house.rawValue, tag: 0)
        
        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem = UITabBarItem(title: "Top Search", image: Image.magnifyingglass.rawValue, tag: 1)
        
        let download = UINavigationController(rootViewController: LikeViewController())
        download.tabBarItem = UITabBarItem(title: "Download", image: Image.faceSmiling.rawValue, tag: 2)
        
        setViewControllers([home, search, download], animated: true)
    }
    
}
