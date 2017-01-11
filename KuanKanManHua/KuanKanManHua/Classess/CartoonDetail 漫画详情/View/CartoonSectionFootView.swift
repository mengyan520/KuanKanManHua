//
//  CartoonSectionFootView.swift
//  快看漫画
//
//  Created by Youcai on 16/8/18.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class CartoonSectionFootView: UITableViewHeaderFooterView {
    //定义回调
    typealias btnBlcok = (_ sender: UIButton) -> Void
    var block:btnBlcok?
    var data:ModelData? {
        didSet {
            
            if data != nil {
                
                
                likeBtn.setTitle("赞 \(data!.likes_count)", for: .normal)
                let  spacing:CGFloat = 7.0
                let  imageSize = likeBtn.imageView!.image!.size;
                likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
                let titleSize = ((likeBtn.titleLabel?.text)! as NSString).size(attributes: [NSFontAttributeName:likeBtn.titleLabel!.font])
                likeBtn.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
                iconView.sd_setImage(with: URL.init(string: (data?.topic!.user!.avatar_url)!), placeholderImage: nil, options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                    
                    
                }
                
                namelbl.text = data?.topic!.user?.nickname
                
            }
        }
    }
    // MARK: - 构造方法
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = WHITE_COLOR
        setUI()
    }
    // MARK: -  设置界面
    private func setUI() {
        
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(followBtn)
        contentView.addSubview(shareBtn)
        contentView.addSubview(topView)
        contentView.addSubview(oldBtn)
        contentView.addSubview(centerView)
        contentView.addSubview(nextBtn)
        contentView.addSubview(bottomView)
        contentView.addSubview(iconView)
        contentView.addSubview(idView)
        contentView.addSubview(namelbl)
        contentView.addSubview(subBtn)
        contentView.addSubview(grayView)
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(contentView.snp.left)
            
        }
        commentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(likeBtn.snp.right)
            make.width.height.equalTo(likeBtn)
        }
        followBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(commentBtn.snp.right)
            make.width.height.equalTo(likeBtn)
        }
        shareBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(followBtn.snp.right)
            make.width.height.equalTo(likeBtn)
            make.right.equalTo(contentView.snp.right)
        }
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(likeBtn.snp.bottom).offset(20)
            make.left.right.equalTo(contentView)
            
            make.height.equalTo(1)
        }
        oldBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left)
            
            make.height.equalTo(40)
        }
        
        nextBtn.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.left.equalTo(oldBtn.snp.right)
            make.width.height.equalTo(oldBtn)
            make.right.equalTo(contentView.snp.right)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(nextBtn.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            
            make.height.equalTo(1)
        }
        centerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(topView.snp.bottom).offset(5)
            make.width.equalTo(1)
            
            make.bottom.equalTo(bottomView.snp.bottom).offset(-5)
        }
        iconView.snp.makeConstraints { (make) in
            
            make.top.equalTo(bottomView.snp.bottom).offset(5)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.height.equalTo(40)
            
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        idView.snp.makeConstraints { (make) in
            make.edges.equalTo(iconView.snp.edges)
        }
        namelbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView.snp.centerY)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH/2.0)
        }
        subBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-10)
            // make.width.equalTo(SCREEN_WIDTH/4.0)
        }
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.bottom.equalTo(contentView.snp.bottom)
            make.right.left.equalTo(contentView)
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    func  btnClick(sender:UIButton)  {
//        if sender.tag == 3 {
//            POSTNOTIFICATION(name: "login", data: nil)
//        } else {
//            POSTNOTIFICATION(name: "CartoonBtn", data: ["data":data!,"sender":sender])
//        }
//        
//    }
    func btnClickBlcok(btnblock:btnBlcok?) {
        block = btnblock
    }
    func  btnClick(sender:UIButton)  {
        if sender.tag == 3 {
            POSTNOTIFICATION(name: "login", data: nil)
        } else {
            block?(sender)
        }
        
    }
    // MARK: - 懒加载
    //图片
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    //标识
    private lazy var idView:UIImageView = {
        let view = UIImageView.init()
        view.image = UIImage.init(named: "ic_details_top_auther_headportrait_v")
        return view
    }()
    //标题
    private lazy var namelbl:UILabel = {
        
        let lbl = UILabel.init(title: "昵称", fontSize: 15, color: BLACK_COLOR, screenInset: 10)
        
        return lbl
    }()
    private lazy var subBtn:UIButton = {
        
        
        let btn = UIButton.init(title: "TA的主页", color:RGB(r: 59, g: 59, b: 59, a: 1.0), SelectedColor: nil, imageName: "ic_details_next_normal", fontSize: 13, target: self, actionName: nil)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -100)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0)
        return btn
        
    }()
    
    
    //点赞
    private lazy var likeBtn:UIButton = {
        let btn =  UIButton.init(title: "赞", color: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_details_praise_normal",SelectedImageName:"ic_details_praise_pressed", fontSize: 12, target: self, actionName:#selector(self.btnClick(sender:)))
        btn.tag = 1
        return btn
    }()
    //评论
    private lazy var commentBtn:UIButton = {
        
        let btn = UIButton.init(title: "评论", color: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_details_comment_normal",SelectedImageName:"ic_details_comment_pressed", fontSize: 12, target: self, actionName:#selector(self.btnClick(sender:)))
        btn.tag = 2
        return btn
    }()
    //关注
    private lazy var followBtn:UIButton = {
        let btn = UIButton.init(title: "关注", color: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_details_followed_normal",SelectedImageName:"ic_details_followed_pressed", fontSize: 12, target: self, actionName:#selector(self.btnClick(sender:)))
        
        
        
        btn.tag = 3
        
        return btn
    }()
    //分享
    private lazy var shareBtn:UIButton = {
        
        let btn =  UIButton.init(title: "分享", color: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_details_share_normal",SelectedImageName:"ic_details_share_pressed", fontSize: 12, target: self, actionName:nil)
        btn.tag = 4
        return btn
    }()
    private lazy var topView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
    //上一篇
    private lazy var oldBtn:UIButton = {
        let btn = UIButton.init(title: "上一篇", color: RGB(r: 59, g: 59, b: 59, a: 1.0), SelectedColor: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_details_prev_normal", fontSize: 12, target: self, actionName: #selector(self.btnClick(sender:)))
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30)
        btn.tag = 5
        return btn
    }()
    //下一篇
    private lazy var nextBtn:UIButton = {
        let btn = UIButton.init(title: "下一篇", color: RGB(r: 59, g: 59, b: 59, a: 1.0), SelectedColor: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_details_next_normal", fontSize: 12, target: self, actionName: #selector(self.btnClick(sender:)))
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40)
        btn.tag = 6
        return btn
    }()
    private lazy var centerView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
    private lazy var bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
    private lazy var grayView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
    
}
