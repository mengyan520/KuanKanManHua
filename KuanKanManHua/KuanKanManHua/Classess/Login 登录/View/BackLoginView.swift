//
//  BackLoginView.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/16.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class BackLoginView: UIScrollView {
    var imgString:String? {
        didSet {
         bottomView.image = UIImage.init(named: imgString!)
        
        }
    }
  // MARK: -  init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentSize = CGSize.init(width: 0, height: SCREEN_HEIGHT)
        showsVerticalScrollIndicator = false
        addSubview(loginBtn)
        addSubview(bottomView)
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-49)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
            make.centerX.equalTo(loginBtn.snp.centerX)
        }
    }
    func  btnClick(sender:UIButton)  {
       
                       POSTNOTIFICATION(name: "login", data: nil)
   
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   // MARK: - 懒加载
    private lazy var loginBtn:UIButton = {
        let btn = UIButton.init(imageName: "login", backImageName: nil, highlightedImageName: "login_pressed", target: self, actionName: #selector(self.btnClick(sender:)))
        
        return btn
    }()
    private lazy var bottomView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "empty_comment_text")
        return view
    }()
}
