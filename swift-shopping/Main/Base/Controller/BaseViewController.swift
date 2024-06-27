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

    func showAlert(title:String,message:String,ok:String,okBlock: @escaping () -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title:ok, style: .default) { (action) in
            okBlock();
        }
        alertController.addAction(action1)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title:String,message:String,ok:String,cancel:String,okBlock: @escaping () -> Void,cancelBlock: @escaping () -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title:ok, style: .default) { (action) in
            okBlock();
        }
        let action2 = UIAlertAction(title:cancel, style: .cancel) { (action) in
            cancelBlock()
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true, completion: nil)
    }
    
}
