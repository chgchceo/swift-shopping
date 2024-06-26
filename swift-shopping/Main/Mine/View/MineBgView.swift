//
//  MineBgView.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/26.
//

import UIKit

protocol MineBgViewDelegate{
    
    //退出登录
    func ClickDoneButtAc() -> Void
    
    //去登录
    func ClickLoginButtAc() -> Void
}



class MineBgView: UIView {

    var delegate:MineBgViewDelegate?
    
    @IBOutlet var bgArr: [UIView]!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var butt: UIButton!
    
    @IBOutlet weak var nameLab: UILabel!
    
    
    @IBOutlet weak var megLab: UILabel!
    
    override func awakeFromNib() {
        
        self.initView()
    }

    func initView() -> Void {
        
        imgView.layer.cornerRadius = 31
        imgView.layer.masksToBounds = true
        
        for  bgView:UIView in self.bgArr {
            
            bgView.layer.cornerRadius = 10
        }
    }
    
    
    @IBAction func logoutButtAc(_ sender: Any) {
        
        if((self.delegate) != nil){
            
            self.delegate?.ClickDoneButtAc()
        }
    }
    
    
    @IBAction func loginButtAc(_ sender: Any) {
        
        if (self.delegate != nil){
            
            self.delegate?.ClickLoginButtAc()
        }
    }
    
}
