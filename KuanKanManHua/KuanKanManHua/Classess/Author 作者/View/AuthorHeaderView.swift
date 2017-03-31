//
//  AuthorHeaderView.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/2/22.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class AuthorHeaderView: UIView {
    typealias btnBlcok = (_ sender: UIButton) -> Void
    var block:btnBlcok?
    var scrollView:UIScrollView?
    var lblHeight:CGFloat = 14
    var isfollow:Bool? {
        didSet {
            if isfollow! {
                 followBtn.isSelected = true
                followBtn.setImage(UIImage.init(named: "ic_album_cover_followed"), for: .normal)
                followBtn.setImage(UIImage.init(named: "ic_album_cover_followed_highlighted"), for: .highlighted)
            }else {
                followBtn.isSelected = false

                followBtn.setImage(UIImage.init(named: "ic_album_cover_follow"), for: .normal)
                followBtn.setImage(UIImage.init(named: "ic_album_cover_follow_highlighted"), for: .highlighted)
            }
            
        }
    }
    var data:ModelData? {
        didSet {
             let url =   ((data?.avatar_url)! as NSString).replacingOccurrences(of: "w180.w", with: "w180")
            iconView.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "ic_login_visible"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            backView.sd_setImage(with: URL.init(string: url), placeholderImage: UIImage.init(named: "ic_login_visible"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                self.backView.image = image?.applyLightEffect()
                
            }
          namelbl.text = data?.nickname
          typelbl.text = data?.u_intro
          countlbl.text = "\(data!.follower_cnt)" +  "粉丝"
          
         countlbl.snp.updateConstraints { (make) in
            make.width.equalTo((NSString.init(string: countlbl.text!)).ew_width(with: Font(fontSize: 13), lineWidth: SCREEN_WIDTH) + 20)
        }
            if (data?.following)! {
                followBtn.isSelected = true
                followBtn.setImage(UIImage.init(named: "ic_album_cover_followed"), for: .normal)
                followBtn.setImage(UIImage.init(named: "ic_album_cover_followed_highlighted"), for: .highlighted)
            }
        }
    }
    // MARK: - 构造方法
    init(frame: CGRect,scrollView:UIScrollView) {
        
        super.init(frame: frame)
        self.scrollView = scrollView
        scrollView .addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        addSubview(backView)
        addSubview(backBtn)
        addSubview(followBtn)
        addSubview(iconView)
        addSubview(idView)
        addSubview(namelbl)
        addSubview(countlbl)
        addSubview(typelbl)
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
            
            
        }
        followBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(25)
            make.right.equalTo(self.snp.right).offset(-10)
            
        }
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(followBtn.snp.centerY)
            
        }
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(64)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        idView.snp.makeConstraints { (make) in
            make.edges.equalTo(iconView.snp.edges)
        }
        namelbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(iconView.snp.bottom).offset(10)
           
        }
        countlbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(namelbl.snp.bottom).offset(10)
            make.width.equalTo(100)
        }
        typelbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(countlbl.snp.bottom).offset(10)
             make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        
        scrollView!.removeObserver(self, forKeyPath: "contentOffset")
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let offsetY = -((change![NSKeyValueChangeKey.newKey]! as AnyObject).cgPointValue.y)
       
        if  offsetY < 1 {
            return
        }
        
        self.height = offsetY > 64 ? offsetY : 64
        let h = 260 - self.height
        var alpha:CGFloat = 1.0
        let isDragUp = h > 0
        let prograss:CGFloat = h / (260 - 64)
        if isDragUp {
            alpha  = 1.0 - prograss - 0.3
        }
        iconView.alpha = alpha
        idView.alpha = alpha
        typelbl.alpha = alpha
        countlbl.alpha = alpha

       
     iconView.snp.updateConstraints { (make) in
        make.top.equalTo(self.snp.top).offset(64 - prograss * 115 - 10)
        }
    }
    // MARK: - 点击事件
    func btnClickBlcok(btnblock:btnBlcok?) {
        block = btnblock
    }
    func  btnClick(sender:UIButton)  {
        if sender.tag == 2 {
            if !MMUtils.userHasLogin() {
                POSTNOTIFICATION(name: "login", data: nil)
            }else{
                block?(sender)
            }
            
        } else {
            block?(sender)
        }
        
    }
    // MARK: - 懒加载
    //返回
    lazy var backBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_album_nav_back_normal", backImageName: nil, highlightedImageName: "ic_album_nav_back_normal", target: self, actionName: #selector(self.btnClick(sender:)))
        
        
        btn.tag = 1
        return btn
    }()
    //关注
    private lazy var followBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_album_cover_follow", backImageName: nil,highlightedImageName: "ic_album_cover_follow_highlighted", target: self, actionName: #selector(btnClick(sender:)))
        
        
        
        btn.tag = 2
        
        return btn
    }()
    //背景图
    
    private lazy var backView:UIImageView = {
        let view = UIImageView()
       
        
        return view
    }()
    //头像
    
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        
        return view
    }()
    //标识
    private lazy var idView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "ic_details_top_auther_headportrait_v")
        return view
    }()
    //昵称
    private lazy var namelbl:UILabel = {
        
        let lbl = UILabel.init(title: "昵称", fontSize: 16, color: WHITE_COLOR, screenInset: 10)
        return lbl
    }()
    //粉丝数量
    private lazy var countlbl:UILabel = {
        let lbl = UILabel.init(title: "粉丝", fontSize: 13, color: RGB(r: 255, g: 204, b: 102, a: 1.0), screenInset: 0)
        lbl.backgroundColor = BLACK_COLOR.withAlphaComponent(0.1)
        lbl.layer.cornerRadius = 8
        lbl.layer.masksToBounds = true
        return lbl
    }()
    //认证
    private lazy var typelbl:UILabel = {
        let lbl = UILabel.init(title: "认证", fontSize: 12, color: WHITE_COLOR, screenInset: 0)
        return lbl
    }()
}
