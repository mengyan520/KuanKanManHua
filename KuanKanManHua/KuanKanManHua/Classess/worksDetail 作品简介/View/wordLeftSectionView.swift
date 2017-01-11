//
//  wordLeftSectionView.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/29.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class wordLeftSectionView: UITableViewHeaderFooterView {
    var data:ModelData? {
        didSet {

            if let des = data?.des {
                 desLbl.text = "作品简介\n\n\(des)"
            }
        }
    }
    // MARK: - 构造方法
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = WHITE_COLOR
        contentView.addSubview(desLbl)
        desLbl.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(10)
              make.right.equalTo(contentView.snp.right).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 懒加载
  
    private   lazy var desLbl:UILabel = {
        
        let lbl = UILabel.init(title: "作品简介", fontSize: 14, color: BLACK_COLOR, screenInset: 10)
        
        return lbl
    }()
    
    
}
