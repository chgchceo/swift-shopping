//
//  MineViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit

class MineViewController: BaseViewController,MineBgViewDelegate {
    
    var bgView = MineBgView()
    var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的"
        
        self.initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    func initView() -> Void {
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-TabBarHeight), style: .grouped)
        
        self.view.addSubview(self.tableView!)
        self.bgView = Bundle.main.loadNibNamed("MineBgView", owner: nil)?.last as! MineBgView
        self.bgView.delegate = self
        self.tableView?.tableHeaderView = self.bgView
        self.tableView?.backgroundColor = HexRGBAlpha(0xf7f7f7,1)
    }

    
    func ClickDoneButtAc() {
        
        
    }
    func ClickLoginButtAc() {
        
        let loginVc = LoginViewController()
        loginVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}
