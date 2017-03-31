    //
    //  wordsHeadView.swift
    //  KuanKanManHua
    //
    //  Created by Youcai on 16/12/28.
    //  Copyright © 2016年 mm. All rights reserved.
    //
    
    import UIKit
    
    class wordsHeadView: UIView {
        //定义回调
        typealias btnBlcok = (_ sender: UIButton) -> Void
        var block:btnBlcok?
        var scrollView:UIScrollView?
        var isfollow:Bool? {
            didSet {
                if isfollow! {
                    followBtn.isSelected =  true
                    followBtn.setImage(UIImage.init(named: "ic_album_cover_followed"), for: .normal)
                    followBtn.setImage(UIImage.init(named: "ic_album_cover_followed_highlighted"), for: .highlighted)
                }else {
                    followBtn.isSelected =  false
                    
                    followBtn.setImage(UIImage.init(named: "ic_album_cover_follow"), for: .normal)
                    followBtn.setImage(UIImage.init(named: "ic_album_cover_follow_highlighted"), for: .highlighted)
                }
                
            }
        }
        var data:ModelData? {
            didSet {
                
                backImgView.sd_setImage(with: URL.init(string: data!.cover_image_url!), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                    self.backView.image = image?.applyLightEffect()
                    
                }
                titlelbl.text = data!.title
                for i in 0..<data!.category!.count {
                    var lbl = self.viewWithTag(100 + i)
                    if (lbl == nil) {
                        
                        lbl = UILabel.init(title: data!.category![i], fontSize: 12, color: WHITE_COLOR, screenInset: 0)
                        lbl?.layer.cornerRadius = 8
                        lbl?.layer.masksToBounds = true
                        lbl?.layer.borderColor = WHITE_COLOR.cgColor
                        lbl?.layer.borderWidth = 1
                        lbl?.tag = 100 + i
                        var x = 10
                        if i > 0 {
                            x = i*(60)
                        }
                        
                        addSubview(lbl!)
                        lbl?.snp.makeConstraints({ (make) in
                            make.top.equalTo(titlelbl.snp.bottom).offset(5)
                            make.width.equalTo(40)
                            make.height.equalTo(18)
                            make.left.equalTo(self.snp.left).offset(x)
                        })
                    }
                }
                
                if (data?.is_favourite)! {
                    followBtn.isSelected =  true
                    followBtn.setImage(UIImage.init(named: "ic_album_cover_followed"), for: .normal)
                    followBtn.setImage(UIImage.init(named: "ic_album_cover_followed_highlighted"), for: .highlighted)
                }
                
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
        // MARK: - 构造方法
        init(frame: CGRect,scrollView:UIScrollView) {
            super.init(frame: frame)
            self.clipsToBounds = true
            self.scrollView = scrollView
            scrollView .addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
            
            addSubview(backImgView)
            addSubview(backView)
            addSubview(maskImgView)
            addSubview(backBtn)
            addSubview(followBtn)
            addSubview(titlelbl)
            
            
            backImgView.snp.makeConstraints { (make) in
                make.edges.equalTo(self.snp.edges)
                
            }
            backView.snp.makeConstraints { (make) in
                make.edges.equalTo(self.snp.edges)
            }
            maskImgView.snp.makeConstraints { (make) in
                make.left.right.equalTo(self)
                make.bottom.equalTo(self.snp.bottom)
                make.height.equalTo(40)
            }
            
            followBtn.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(25)
                make.right.equalTo(self.snp.right).offset(-10)
                
            }
            backBtn.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(20)
                make.centerY.equalTo(followBtn.snp.centerY)
                //make.width.height.equalTo(30)
            }
            titlelbl.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(10)
                make.bottom.equalTo(self.snp.bottom).offset(-30)
                
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
            
            if offsetY > 64 {
                
                var alpha:CGFloat = 0.0
                
                alpha = (200 * 0.5)/offsetY-0.3;
                maskImgView.alpha = 1-alpha;
                if alpha > 0.7 {
                    backView.alpha = 0.7;
                }else {
                    backView.alpha = alpha
                }
                UIView.animate(withDuration: 0.25, animations: {
                    self.titlelbl.transform = .identity
                    if ((self.data?.category) != nil) {
                        for i in 0..<self.data!.category!.count {
                            let lbl = self.viewWithTag(100+i)
                            lbl?.isHidden = false
                            
                        }
                    }
                })
                
                
                
            }else  {
                
                
                
                UIView.animate(withDuration: 0.25, animations: {
                    
                    
                    self.titlelbl.transform = CGAffineTransform.init(translationX: SCREEN_WIDTH/2.0 - self.titlelbl.width/2.0 - 10 , y: 15)
                    if !(self.data == nil) {
                        for i in 0..<self.data!.category!.count {
                            let lbl = self.viewWithTag(100+i)
                            lbl?.isHidden = true
                            
                        }
                    }
                })
                maskImgView.alpha = 0
            }
            
        }
        // MARK: - 懒加载
        lazy var backgView:UIView = {
            let view = UIView.init()
            
            return view
        }()
        lazy var backImgView:UIImageView = {
            let view = UIImageView.init()
            //  view.userInteractionEnabled = true
            
            view.contentMode = .scaleAspectFill
            return view
        }()
        lazy var maskImgView:UIImageView = {
            let view = UIImageView.init()
            view.image = UIImage.init(named: "ic_album_mask")
            return view
        }()
        //模糊视图
        lazy var backView:UIImageView = {
            let view = UIImageView.init()
            
            
            return view
        }()
        //返回
        lazy var backBtn:UIButton = {
            let btn = UIButton.init(imageName: "ic_album_nav_back_normal", backImageName: nil, highlightedImageName: "ic_album_nav_back_normal", target: self, actionName: #selector(self.btnClick(sender:)))
            // btn.backgroundColor = BLACK_COLOR.withAlphaComponent(0)
            
            btn.tag = 1
            return btn
        }()
        //关注
        private lazy var followBtn:UIButton = {
            let btn = UIButton.init(imageName: "ic_album_cover_follow", backImageName: nil,highlightedImageName: "ic_album_cover_follow_highlighted", target: self, actionName: #selector(btnClick(sender:)))
            
            
            
            btn.tag = 2
            
            return btn
        }()
        //标题
        private lazy var titlelbl:UILabel = {
            
            let lbl = UILabel.init(title: "标题", fontSize: 18, color: WHITE_COLOR, screenInset: 0)
            return lbl
        }()
        
        
    }
