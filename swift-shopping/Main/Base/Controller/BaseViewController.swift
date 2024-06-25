//
//  BaseViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var loadView = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    func showLoadingView() -> Void {
        
        self.loadView.modalPresentationStyle = .overFullScreen
        self.present(self.loadView, animated: false)
    }
    
    func hiddenLoadingView() -> Void {
        
        
        self.loadView.dismiss(animated: false)
    }

}
