//
//  MyTabBarController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit

class MyTabBarController: UITabBarController {

    let nc1 = MyNavigationController.init(rootViewController: HomeViewController())
    let vc2 = MyNavigationController.init(rootViewController: CategoryViewController())
        let vc3 = MyNavigationController(rootViewController: CartViewController())
        let vc4 = MyNavigationController(rootViewController: MineViewController())

        override func viewDidLoad() {
            super.viewDidLoad()
//            let tabBarNormalAttribute:[NSAttributedString.Key:Any] = [.foregroundColor : UIColor.gray,.font: UIFont.systemFont(ofSize: 14)]
//            let tabBarSelectedAttribute:[NSAttributedString.Key:Any] = [.foregroundColor : UIColor.blue,.font: UIFont.systemFont(ofSize: 14)]
            let tabBarNormalAttribute:[NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 14)]
            let tabBarSelectedAttribute:[NSAttributedString.Key:Any] = [.font: UIFont.systemFont(ofSize: 14)]
            let tabBarItem1 = UITabBarItem()
            tabBarItem1.title = "首页"
            tabBarItem1.setTitleTextAttributes(tabBarNormalAttribute, for: .normal)
            tabBarItem1.setTitleTextAttributes(tabBarSelectedAttribute, for: .selected)
            tabBarItem1.image = UIImage(systemName: "homekit")?.withTintColor(.gray)
            tabBarItem1.selectedImage = UIImage(systemName: "homekit")?.withTintColor(.blue)
            
            nc1.tabBarItem = tabBarItem1
            
            let tabBarItem2 = UITabBarItem()
            tabBarItem2.title = "分类"
            tabBarItem2.setTitleTextAttributes(tabBarNormalAttribute, for: .normal)
            tabBarItem2.setTitleTextAttributes(tabBarSelectedAttribute, for: .selected)
            tabBarItem2.image = UIImage(systemName: "poweroutlet.type.o")
            vc2.tabBarItem = tabBarItem2
            
            let tabBarItem3 = UITabBarItem()
            tabBarItem3.title = "购物车"
            tabBarItem3.setTitleTextAttributes(tabBarNormalAttribute, for: .normal)
            tabBarItem3.setTitleTextAttributes(tabBarSelectedAttribute, for: .selected)
            tabBarItem3.image = UIImage(systemName: "cart")
            vc3.tabBarItem = tabBarItem3
            
            let tabBarItem4 = UITabBarItem()
            tabBarItem4.title = "我的"
            tabBarItem4.setTitleTextAttributes(tabBarNormalAttribute, for: .normal)
            tabBarItem4.setTitleTextAttributes(tabBarSelectedAttribute, for: .selected)
            tabBarItem4.image = UIImage(systemName: "person")
            vc4.tabBarItem = tabBarItem4
            
            viewControllers = [nc1, vc2, vc3, vc4]
            self.viewControllers = viewControllers
            self.tabBar.backgroundColor = UIColor.groupTableViewBackground
        }

}
