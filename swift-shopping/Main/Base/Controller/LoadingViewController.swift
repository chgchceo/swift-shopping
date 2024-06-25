//
//  LoadingViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/25.
//

import UIKit

class LoadingViewController: UIViewController {

    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var megLab: UILabel!
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        activityView.startAnimating()
        self.bgView.layer.cornerRadius = 10
    }


}
