//
//  TabBarViewController.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 19/05/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    var customTabBar: TabNavigationMenu!
    var tabBarHeight: CGFloat = 72.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabBar()
    }
    
    func loadTabBar() {
        // create and load custom tabBar here
        let tabItems: [TabItem] = [.search, .qrCode, .order, .account]
        
        setupCustomTabBar(tabItems) { controllers in
            self.viewControllers = controllers
        }
        
        selectedIndex = 0 // default first item selected
    }
    
    func setupCustomTabBar(_ items: [TabItem], completion: @escaping([UIViewController]) -> Void) {
        // handle creation of the tab bat and attach touch event listeners
        let frame = CGRect(x: tabBar.frame.origin.x,
                           y: tabBar.frame.origin.y,
                           width: tabBar.frame.size.width - 40,
                           height: 72)
        
        var controllers = [UIViewController]()
        
        // hide the tab bar
        tabBar.isHidden = true
        
        customTabBar = TabNavigationMenu(menuItems: items, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.layer.cornerRadius = customTabBar.frame.height / 2
        
        customTabBar.itemTapped = self.changeTab
        
        // adding it to the view
        view.addSubview(customTabBar)
        
        // adding positioning constraints to place the tab bar where it should be
        setupTabBarConstraints(to: customTabBar)
        
        for i in 0..<items.count {
            // fetch the matching view controller and append here
            controllers.append(items[i].viewController)
        }
        
        view.layoutIfNeeded()
        
        // return the completion
        completion(controllers)
    }
    
    func setupTabBarConstraints(to customTabBar: TabNavigationMenu) {
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 16),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -16),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.size.width - 32),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight), // fixed height for nav menu
            customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -24),
        ])
    }
    
    func changeTab(tab: Int) {
        selectedIndex = tab
    }
}
