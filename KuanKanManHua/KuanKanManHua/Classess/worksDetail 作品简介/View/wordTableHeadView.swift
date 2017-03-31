
//
//  wordTableHeadView.swift
//  快看漫画
//
//  Created by Youcai on 16/8/4.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class wordTableHeadView: UIView {
    //定义回调
    typealias btnBlcok = (_ sender: UIButton) -> Void
    var block:btnBlcok?
    var currentBtn = UIButton.init()
    // MARK: - 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = WHITE_COLOR
        addSubview(leftBtn)
        addSubview(rightBtn)
        addSubview(bottomLine)
       
        addSubview(yellowLine)
        currentBtn = rightBtn
        leftBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
        }
        rightBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftBtn.snp.right)
            make.width.equalTo(self.leftBtn)
            make.right.top.bottom.equalTo(self)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
           make.height.equalTo(1)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        yellowLine.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.rightBtn.snp.centerX)
            make.width.equalTo(SCREEN_WIDTH/4)
            make.height.equalTo(1)
            make.bottom.equalTo(self.snp.bottom)

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 点击事件
    func btnClickBlcok(btnblock:btnBlcok?) {
        block = btnblock
    }
    func  btnClick(sender:UIButton)  {
        currentBtn.isSelected = false
         currentBtn = sender
        
          sender.isSelected = true
         UIView.animate(withDuration: 0.25) {
            self.yellowLine.centerX = sender.centerX
        }
        block?(sender)
    }
 // MARK: - 懒加载
     lazy var leftBtn:UIButton = {
     let btn = UIButton.init(title: "详情", color: LIGHTGRAY_COLOR, SelectedColor: BLACK_COLOR, imageName: nil, fontSize: 16, target: self, actionName: #selector(self.btnClick(sender:)))
        
        btn.tag = 1
        return btn
    }()
     lazy var rightBtn:UIButton = {
        let btn = UIButton.init(title: "选集", color: LIGHTGRAY_COLOR, SelectedColor: BLACK_COLOR, imageName: nil, fontSize: 16, target: self, actionName: #selector(self.btnClick(sender:)))
        btn.isSelected = true
        btn.tag = 2
        return btn
    }()
    private lazy var bottomLine:UIView = {
        let view = UIView.init()
        view.backgroundColor = WHcolor
        return view
    }()
    
    private lazy var yellowLine:UIView = {
        let view = UIView.init()
        view.backgroundColor = RGB(r: 238, g: 167, b: 0, a: 1.0)
        return view
    }()
}
