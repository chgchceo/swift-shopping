//
//  GoodsDetailView.swift
//  swift-shopping
//
//  Created by cheng on 2024/7/8.
//

import SwiftUI

struct GoodsDetailView: View {
    
    var goodsId:String?
    
    @State var detail:GoodsDetailModel?
    
    @State var bannerData:[GoodsBannerModel]?
    
    var body: some View {
       
        ZStack{
            
            VStack{
                
                HStack{
                    
//                    if bannerData?.count ?? 0 > 0{
                        
                        Image("banner1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenWidth,height: 200)
                        
//                    }
                }
                
                HStack{
                    
                    Text("¥\(detail?.goods_price_min ?? "")")
                        .foregroundColor(Color.red)
                        .font(.system(size: 18).bold())
                    
                    Text("¥\(detail?.goods_price_max ?? "")")
                        .strikethrough()
                        .foregroundColor(Color.gray)
                        .font(.system(size: 11))
                        
                    Spacer()
                    Text("已售\(detail?.goods_sales ?? "0")件")
                    
                }
                .padding(.horizontal,10)
                .padding(.bottom,10)
                
                Text(detail?.goods_name ?? "")
                    .padding(.horizontal,10)
                    .foregroundColor(.black)
                    .font(.system(size: 18).bold())
                    .lineSpacing(2)
                    
                
                HStack{
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.red)
                    
                    Text("七天无理由退货")
                        .foregroundColor(.black)
                        .bold()
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.red)
                    Text("48小时发货")
                        .foregroundColor(.black)
                        .bold()
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .padding(.horizontal,10)
                .frame(width: ScreenWidth-24,height: 45)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                
                
                HStack{
                    
                    Text("商品评价(10条)")
                        .font(.system(size: 18))
                    
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        
                        HStack{
                            Text("查看更多")
                            Image(systemName: "chevron.forward")
                        }
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                        .padding(.trailing,5)
                    })
                }
                .padding()
                
                Spacer()
            }
            
            VStack{
                
                Spacer()
                
                Divider()
                    .foregroundColor(.black)
                HStack{
                    
                    
                    
                    VStack{
                        
                        Image(systemName: "homekit")
                        Text("首页")
                    }
                    Spacer()
                    VStack{
                        
                        Image(systemName: "cart")
                        Text("购物车")
                    }
                    Spacer()
                    Button {
                        
                        
                    } label: {
                        
                        Text("加入购物车")
                            .frame(width: 100,height: 40)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        
                    }
                    Spacer()
                    Button {
                        
                        
                    } label: {
                        
                        Text("立刻购买")
                            .frame(width: 100,height: 40)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        
                    }
                    
                    
                }
                .padding(.horizontal,15)
                .frame(width: ScreenWidth,height: 60)
                .background(Color.white)
            }
            
            
        }
//        .frame(width: ScreenWidth,height: ScreenHeight)
        .onAppear(){
            
            self.initData()
            self.initCommentData()
        }
    }
    
    func initData() -> Void {
        
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/goods/detail&goodsId=\(goodsId ?? "")") { request, responseData in
            
            let model = GoodsListModel.deserialize(from: responseData as? NSDictionary)
            
            self.detail = model?.data?.detail
            self.bannerData = model?.data?.detail?.goods_images
        }
    }
    
    func initCommentData() -> Void {
        
        
    }
}

#Preview {
    GoodsDetailView()
}
