//
//  wordSectionVIew.swift
//  快看漫画
//
//  Created by Youcai on 16/8/4.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class wordRightSectionView: UITableViewHeaderFooterView {
    var data:ModelData? {
        didSet {
            
          titleLbl.text = data?.update_status
        }
    }
   // typealias btnBlcok = (_ sender: UIButton) -> Void
   // var block:btnBlcok?
    // MARK: - 构造方法
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = WHITE_COLOR
        contentView.addSubview(sortBtn)
        contentView.addSubview(titleLbl)
        
        sortBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView);
            make.left.equalTo(contentView.snp.left).offset(10);
            make.width.equalTo(SCREEN_WIDTH-20)
            make.height.equalTo(20)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 点击事件
//    func btnClickBlcok(btnblock:btnBlcok?) {
//        ///block = btnblock
//    }
    func  btnClick(sender:UIButton)  {
        //block?(sender)
        POSTNOTIFICATION(name: "sort", data: ["data":sender])
    }
    
    // MARK: - 懒加载
    private lazy var sortBtn:UIButton = {
        let btn =    UIButton.init(title: "倒序", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: "ic_album_sort_descending", fontSize: 10, target: self, actionName: #selector(wordRightSectionView.btnClick(sender:)))
        
        
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15)
        btn.setImage(UIImage.init(named: "ic_album_sort_ascending"), for: .selected)
        btn.setTitle("正序", for: .selected)
        btn.tag = 1
        return btn
    }()
    private   lazy var titleLbl:UILabel = {
        
        let lbl = UILabel.init(title: "漫画列表", fontSize: 14, color: BLACK_COLOR, screenInset: 10)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    
}
