//
//  CommentFootView.swift
//  快看漫画
//
//  Created by Youcai on 16/7/26.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class CommentFootView: UIView {
    
    
    // MARK: - 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 设置界面
    private func setUI() {
        addSubview(lbl)
        addSubview(grayView)
        
        lbl.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
        }
        grayView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(1)
            make.bottom.equalTo(self.snp.bottom)
        }
        
    }
    
    
    // MARK: - 懒加载
    //查看评论
    private lazy var lbl:UILabel = {
        let lbl = UILabel.init(title: "查看更多评论", fontSize: 12, color: RGB(r: 59, g: 59, b: 59, a: 1.0), screenInset: 0)
        
        return lbl
    }()
    //背景
    private lazy var grayView:UIView = {
        let view = UIView.init()
        view.backgroundColor = WHcolor
        return view
    }()
}
