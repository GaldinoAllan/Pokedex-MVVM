//
//  TabItem.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 19/05/21.
//

import UIKit

enum TabItem: String, CaseIterable {
    case search = "Search"
    case qrCode = "QR Code"
    case order = "Order"
    case account = "Account"
    
    // setting every ViewController
    var viewController: UIViewController {
        switch self {
            case .search:
                return SearchViewController()
            case .qrCode:
                return QrCodeViewController()
            case .order:
                return OrderViewController()
            case .account:
                return AccountViewController()
        }
    }
    
    var icon: UIImage {
        switch self {
            case .search:
                return UIImage(named: "ic_search")!
            case .qrCode:
                return UIImage(named: "ic_qr_code")!
            case .order:
                return UIImage(named: "ic_order")!
            case .account:
                return UIImage(named: "ic_account")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
