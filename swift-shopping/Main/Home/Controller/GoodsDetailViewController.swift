import UIKit
import SwiftUI
  
class GoodsDetailViewController: BaseViewController {
      
    var hostView: UIHostingController<GoodsDetailView>?
    var goodsId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.title = "商品详情"
          
        self.initView()
  
        // 确保将 hostView 的视图添加到当前视图控制器的视图中
        if let hostView = hostView {
            addChild(hostView)
            view.addSubview(hostView.view)
            hostView.didMove(toParent: self)
  
            // 设置 hostView 的视图框架，以便它填充整个视图控制器
            hostView.view.frame = view.bounds
            hostView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
  
    func initView() {
        hostView = UIHostingController(rootView: GoodsDetailView(goodsId: self.goodsId))
    }
}
