//
//  CartoonSectionHeaderView.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/4.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class CommentSectionHeaderView: UITableViewHeaderFooterView {
    var name:String? {
        didSet {
           namelbl.text = name
        }
    }
    // MARK: - 构造方法
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = WHITE_COLOR
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -  设置界面
    private func setUI() {
        contentView.addSubview(leftView)
        contentView.addSubview(namelbl)
        contentView.addSubview(grayView)
        leftView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(5)
            make.height.equalTo(15)
        }
        namelbl.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right).offset(5)
            make.centerY.equalTo(self.snp.centerY)
            
        }
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(namelbl.snp.bottom).offset(5)
            make.left.right.equalTo(contentView)
            
            make.height.equalTo(1)
        }
    }
    // MARK: - 懒加载
    
    private lazy var leftView:UIView = {
        let view = UIView()
        view.backgroundColor = mainColor
        view.layer.cornerRadius = 3
        return view
    }()
    
    
    private lazy var namelbl:UILabel = {
        
        let lbl = UILabel.init(title: "评论", fontSize: 14, color: BLACK_COLOR, screenInset: 10)
        
        return lbl
    }()
    private lazy var grayView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
}
