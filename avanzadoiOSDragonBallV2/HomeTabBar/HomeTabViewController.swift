//
//  HomeTabViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTabs()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchHeroes), name: Notification.Name("fetchHeroes"), object: nil)
        
    }
    
    @objc func fetchHeroes() {
        print("Looking for new herores from HomeTabBarController")
    }
    
    private func setupTabs(){
        let navigationController1 = UINavigationController(rootViewController: HeroesListViewController())
       
        let tabImage = UIImage(systemName: "text.justify")!
        navigationController1.tabBarItem = UITabBarItem(title: "TableView", image: tabImage, tag: 0)
        /*
        let navigationController2 = UINavigationController(rootViewController: MapHeroesViewController())
        let tabImg = UIImage(systemName: "square.grid.3x3.topleft.filled")!
        navigationController2.tabBarItem = UITabBarItem(title: "MapView", image: tabImg, tag: 1)
        
        
        viewControllers = [navigationController1, navigationController2]
        */
        viewControllers = [navigationController1]

        
    }
    private func setupLayout() {
        tabBar.backgroundColor = .systemBackground
    }

}
