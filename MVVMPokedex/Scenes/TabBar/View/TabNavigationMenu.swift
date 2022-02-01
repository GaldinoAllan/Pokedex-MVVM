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
        
        layer.backgroundColor = UIColor.white.cgColor
        
        for i in 0 ..< menuItems.count {
            let itemWidth = frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = createTabItem(item: menuItems[i])
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = i
            
            addSubview(itemView)
            
            // setting constraints
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor)
            ])
            
            setNeedsLayout()
            layoutIfNeeded()
            activateTab(tab: 0) // activate first tab
        }
    }
    
    func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)

        itemIconView.image = item.icon.withRenderingMode(.automatic)
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true

        tabBarItem.layer.backgroundColor = UIColor.white.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        // setting constraints
        setupTabItemConstraints(for: tabBarItem, icon: itemIconView)

        // each item should be able to trigger an action on tap
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(self.handleTap)))

        return tabBarItem
    }

    func setupTabItemConstraints(for tabBarItem: UIView, icon: UIImageView) {
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24), // fixed height for tab item(24pts)
            icon.widthAnchor.constraint(equalToConstant: 24), // fixed width for tab item(24pts),
            icon.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor), // center the image X to the container
            icon.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor), // center the image Y to the container
            icon.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor, constant: 35)
        ])
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        switchTab(from: activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        let activeItemSize = tabToActivate.frame.size.height - 20
        
        let activeItemLayer = CALayer()
        activeItemLayer.backgroundColor = UIColor.lightGray.cgColor
        activeItemLayer.name = "active border"
        activeItemLayer.cornerRadius = activeItemSize / 2
        activeItemLayer.frame = CGRect(x: 21,
                                   y: 10,
                                   width: activeItemSize,
                                   height: activeItemSize)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8,
                           delay: 0.0,
                           options: [.curveEaseIn, .allowUserInteraction],
                           animations: {
                            tabToActivate.layer.insertSublayer(activeItemLayer, at: 0)
                            tabToActivate.setNeedsLayout()
                            tabToActivate.layoutIfNeeded()
                           })
            self.itemTapped?(tab)
        }
        activeItem = tab
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
