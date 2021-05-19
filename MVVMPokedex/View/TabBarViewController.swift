//
//  TabBarViewController.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 19/05/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create instance of view controllers
        let searchVC = SearchViewController()
        let qrCodeVC = QrCodeViewController()
        let orderVC = OrderViewController()
        let accountVC = AccountViewController()
        
        // set titles
        searchVC.title = "Search"
        qrCodeVC.title = "QR Code"
        orderVC.title = "Order"
        accountVC.title = "Account"
        
        // changing tabBar tint color
        tabBar.tintColor = .systemPink
        
        // assign view controllers to tab bar
        self.setViewControllers([searchVC, qrCodeVC, orderVC, accountVC], animated: false)
        
        let imagesNames = ["ic_search", "ic_qr_code", "ic_order", "ic_account"]
        
        // setting image for each item in tabBar
        guard let items = self.tabBar.items else { return }
        
        for i in 0...3 {
            items[i].image = UIImage(named: imagesNames[i])
        }
    }
}
