//
//  LoginViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/26.
//

import UIKit
import Toast_Swift

class LoginViewController: BaseViewController {

    var captchaKey:String = ""
    @IBOutlet weak var phoneField: UITextField!
    
    
    @IBOutlet weak var imgField: UITextField!
    
    @IBOutlet weak var codeField: UITextField!
    
    @IBOutlet weak var imgButt: UIButton!
    
    
    @IBOutlet weak var codeButt: UIButton!
    
    
    @IBOutlet weak var doneButt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "会员登录"
        self.initView()
        self.initData()
    }
    
    func initView() -> Void {
        
        self.doneButt.layer.cornerRadius = 22
        
    }
    //加载图像验证码
    func initData() -> Void {
        
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/captcha/image") { request, responseData in
            
            let model:LoginImageModel = LoginImageModel.deserialize(from: responseData as? [String:Any]) ?? LoginImageModel()
            
            if model.status == 200 {
                
                let base64 = model.data?.base64
                self.captchaKey = model.data!.key
                let image = self.base64StringToImage(base64String: base64 ?? "")
                self.imgButt.setImage(image, for: UIControl.State.normal)
                
            }
        }
    }
    //请求短信验证码
    func initCodeData() -> Void {
        
        let phone = self.phoneField.text ?? ""
        let imgCode = self.imgField.text ?? ""
        
        
        if (phone.count == 0){
            
            self.view.makeToast("请输入手机号码",position: .center)
            
            return
        }
        
        if (imgCode.count == 0){
            
            self.view.makeToast("请输入图形验证码",position: .center)
            return
        }
        
        let param:[String:Any] = [
            
            "mobile":phone,
            "captchaCode":imgCode,
            "captchaKey":self.captchaKey,
        ]
        
        LNRequest.post(path: "https://smart-shop.itheima.net/index.php?s=/api/captcha/sendSmsCaptcha",parameters: param) { request, responseData in
            
            let model:LoginImageModel = LoginImageModel.deserialize(from: responseData as? [String:Any])!
            
            if model.status == 200{
                
                self.view.makeToast("验证码发送成功，请注意查收",position: .center)
                
            }else{
                
                self.view.makeToast("发送失败，请检查网络是否连接",position: .center)
            }
            
        }
        
        
    }
    
    func base64StringToImage(base64String: String) -> UIImage? {
        // 去除可能的填充字符（例如，如果字符串以'data:image/png;base64,'开头）
        let base64DataDecoded: Data?
          
        if base64String.hasPrefix("data:image/png;base64,") {
            let base64Data = base64String.replacingOccurrences(of: "data:image/png;base64,", with: "")
            base64DataDecoded = Data(base64Encoded: base64Data, options: .ignoreUnknownCharacters)
        } else if base64String.hasPrefix("data:image/jpeg;base64,") {
            let base64Data = base64String.replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
            base64DataDecoded = Data(base64Encoded: base64Data, options: .ignoreUnknownCharacters)
        } else {
            base64DataDecoded = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters)
        }
          
        // 尝试从解码的数据中创建UIImage
        if let decodedData = base64DataDecoded, let image = UIImage(data: decodedData) {
            return image
        }
          
        // 如果数据无法解码或图像无法从数据中创建，则返回nil
        return nil
    }
      
    
    @IBAction func imgButtAc(_ sender: Any) {
        
        self.initData()
    }
    
    @IBAction func codeButtAc(_ sender: Any) {
        
        self.initCodeData()
    }
    
    //登录接口
    @IBAction func doneButtAc(_ sender: Any) {
        
        let phone = self.phoneField.text ?? ""
        let imgCode = self.imgField.text ?? ""
        let smsCode = self.codeField.text ?? ""
        
        if (phone.count == 0){
            
            self.view.makeToast("请输入手机号码",position: .center)
            
            return
        }
        
        if (imgCode.count == 0){
            
            self.view.makeToast("请输入图形验证码",position: .center)
            return
        }
        if (smsCode.count == 0){
            
            self.view.makeToast("请输入短信验证码",position: .center)
            return
        }
        let isParty:Bool = true
        let param:[String:Any] = ["form":
        
                                    [
                                        
                                        "mobile":phone,
                                        "isParty":isParty,
                                        "partyData":["":""],
                                        "smsCode":smsCode
                                    ]
        
        ]
       
        LNRequest.post(path: "https://smart-shop.itheima.net/index.php?s=/api/passport/login",parameters: param) { request, responseData in
            
            
        }
    }
    
}
