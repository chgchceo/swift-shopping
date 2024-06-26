//
//  MineViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit

class MineViewController: BaseViewController {
    
    var bgView = MineBgView()
    var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的"
        
        self.initView()
    }
    

    func initView() -> Void {
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-NavigationBarHeight-TabBarHeight), style: .grouped)
        
        self.view.addSubview(self.tableView!)
        self.bgView = Bundle.main.loadNibNamed("MineBgView", owner: nil)?.last as! MineBgView
        self.tableView?.tableHeaderView = self.bgView
        self.tableView?.backgroundColor = HexRGBAlpha(0xf7f7f7,1)
    }

}
