//
//  TabBarViewController.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 19/05/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    var customTabBar: TabNavigationMenu!
    var tabBarHeight: CGFloat = 67.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }
    
    func loadTabBar() {
        // create and load custom tabBar here
        let tabItems: [TabItem] = [.search, .qrCode, .order, .account]
        
        self.setupCustomTabBar(tabItems) { controllers in
            self.viewControllers = controllers
        }
        
        self.selectedIndex = 0 // default first item selected
    }
    
    func setupCustomTabBar(_ items: [TabItem], completion: @escaping([UIViewController]) -> Void) {
        // handle creation of the tab bat and attach touch event listeners
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        
        // hide the tab bar
        tabBar.isHidden = true
        
        self.customTabBar = TabNavigationMenu(menuItems: items, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        
        // adding it to the view
        self.view.addSubview(customTabBar)
        
        // adding positioning constraints to place the tab bar where it should be
        self.setupTabBarConstraints(to: customTabBar)
        
        for i in 0..<items.count {
            // fetch the matching view controller and append here
            controllers.append(items[i].viewController)
        }
        
        self.view.layoutIfNeeded()
        
        // return the completion
        completion(controllers)
    }
    
    func setupTabBarConstraints(to customTabBar: TabNavigationMenu) {
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight), // fixed height for nav menu
            customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
