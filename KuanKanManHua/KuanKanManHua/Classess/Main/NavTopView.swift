//
//  NavTopView.swift
//  kuaikan
//
//  Created by 马鸣 on 2016/12/3.
//  Copyright © 2016年 马鸣. All rights reserved.
//

import UIKit
protocol NavTopDel {
    func  NavTopClick(sender:UISegmentedControl)
}
class NavTopView: UISegmentedControl {
    var  del:NavTopDel?
    var items:[String]? {
        didSet {
            var  i = 0
        
            for item in items! {
                insertSegment(withTitle: item, at: i, animated: false)
                
                i = i + 1
            }
            selectedSegmentIndex = 0
        }
    }
    //MARK: - 初始化
   
    init() {
  
        super.init(frame: CGRect.init(x: (SCREEN_WIDTH-150)/2, y: 0, width: 150, height: 30))
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        let att = [NSFontAttributeName:Font(fontSize: 16),NSForegroundColorAttributeName:WHITE_COLOR,NSBackgroundColorAttributeName:mainColor]
        setTitleTextAttributes(att, for: .selected)
        let attt = [NSFontAttributeName:Font(fontSize: 16),NSForegroundColorAttributeName:mainColor]
        
        setTitleTextAttributes(attt, for: .normal)
        tintColor = mainColor
        addTarget(self, action: #selector(self.segmentedSelected(sender:)), for: .valueChanged)
        
        layer.cornerRadius = 15
        clipsToBounds = true
        layer.borderWidth = 1.5
        layer.borderColor = mainColor.cgColor
    
    }
    // MARK: - 事件
    @objc
    private func segmentedSelected(sender:UISegmentedControl) {
        
        del?.NavTopClick(sender: sender)
    }
    
}
