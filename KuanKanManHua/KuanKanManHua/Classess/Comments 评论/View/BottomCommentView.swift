//
//  BottomCommentView.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/5.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class BottomCommentView: UIView {
    var data:Feeds? {
        didSet {
            rightBtn.setTitle("\(data!.comments_count)", for: .normal)
        
        }
    }
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
        addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-5)
            make.centerY.equalTo(self.snp.centerY)
        }
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(5)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(rightBtn.snp.left).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -  懒加载
    private lazy var textView:UITextView = {
        let view = UITextView()
        
        return view
    }()
    private lazy var rightBtn:UIButton = {
        
        let btn = UIButton.init(title: "1", color: LIGHTGRAY_COLOR, SelectedColor: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_details_praise_normal", SelectedImageName: "ic_details_praise_pressed", fontSize: 12 , target: self, actionName: nil)
        btn.tag = 1
        return btn
    }()
}
