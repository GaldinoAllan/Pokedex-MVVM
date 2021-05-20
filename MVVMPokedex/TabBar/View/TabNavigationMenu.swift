//
//  TabNavigationMenu.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 19/05/21.
//

import UIKit

class TabNavigationMenu: UIView {
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        
        self.layer.backgroundColor = UIColor.white.cgColor
        
        for i in 0 ..< menuItems.count {
            let itemWidth = frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = self.createTabItem(item: menuItems[i])
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = i
            
            self.addSubview(itemView)
            
            // setting constraints
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor)
            ])
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.activateTab(tab: 0) // activate first tab
        }
    }
    
    func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)

        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true

        itemIconView.image = item.icon.withRenderingMode(.automatic)
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true

        tabBarItem.layer.backgroundColor = UIColor.white.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        // setting constraints
        setupTabItemConstraints(for: tabBarItem,title: itemTitleLabel, icon: itemIconView)

        // each item should be able to trigger an action on tap
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(self.handleTap)))

        return tabBarItem
    }

    func setupTabItemConstraints(for tabBarItem: UIView, title: UILabel, icon: UIImageView) {
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 25), // fixed height for tab item(25pts)
            icon.widthAnchor.constraint(equalToConstant: 25), // fixed width for tab item(25pts),
            icon.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            icon.topAnchor.constraint(equalTo: tabBarItem.topAnchor, constant: 8),
            icon.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor, constant: 35),

            title.heightAnchor.constraint(equalToConstant: 13), // fixed height for title label
            title.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor), // position label full width across tab bar
            title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 4) // position label 4pts below item icon
        ])
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        let borderWidth = tabToActivate.frame.size.width - 20
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.green.cgColor
        borderLayer.name = "active border"
        borderLayer.frame = CGRect(x: 10, y: 0, width: borderWidth, height: 2)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8,
                           delay: 0.0,
                           options: [.curveEaseIn, .allowUserInteraction],
                           animations: {
                            tabToActivate.layer.addSublayer(borderLayer)
                            tabToActivate.setNeedsLayout()
                            tabToActivate.layoutIfNeeded()
                           })
            self.itemTapped?(tab)
        }
        self.activeItem = tab
    }
    
    func deactivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        let layersToRemove = inactiveTab.layer.sublayers!.filter { sublayer in
            sublayer.name == "active border"
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: [.curveEaseIn, .allowUserInteraction],
                           animations: {
                            layersToRemove.forEach { $0.removeFromSuperlayer()}
                            inactiveTab.setNeedsLayout()
                            inactiveTab.layoutIfNeeded()
                           })
        }
    }
}
