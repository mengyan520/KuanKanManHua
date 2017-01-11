//
//  RightCell.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/28.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class RightCell: UITableViewCell {
    func rowHeight(data: Comics) -> CGFloat {
        
        self.data = data
        
        
        contentView.layoutIfNeeded()
        
        
        return grayView.frame.maxY
    }
    var data:Comics? {
        didSet {
            
            iconView.sd_setImage(with: URL.init(string: data!.cover_image_url!), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
           
            titlebl.text = data?.title
            timelbl.text = Date.init().timeStringWithInterval(time: TimeInterval(data!.updated_at * 1000))
            if data!.likes_count > 10000 {
                likeBtn.setTitle(" \((data!.likes_count)/10000)万", for: .normal)
            }else {
                likeBtn.setTitle(" \(data!.likes_count)", for: .normal)
            }
        }
    }
    
    // MARK: - init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
    }
    private func setUI() {
        contentView.addSubview(iconView)
        
        
        
        contentView.addSubview(titlebl)
        contentView.addSubview(timelbl)
        contentView.addSubview(likeBtn)
        
        contentView.addSubview(grayView)
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(80)
            
        }
        
        titlebl.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top).offset(5)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH-120-30)
            
            
        }
        timelbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.bottom).offset(-5)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH-120-30)
            
            
        }
        
        
        
        likeBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.bottom)
            make.right.equalTo(contentView.snp.right).offset(-10)
            
            
        }
        
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // MARK: - 懒加载
    //图片
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        
        
        return view
    }()
    
    //标题
    private lazy var titlebl:UILabel = {
        let lbl = UILabel.init(title: "昵称", fontSize: 14, color: BLACK_COLOR, screenInset: 10)
        
        
        lbl.numberOfLines = 1
        return lbl
    }()
    //时间
    private lazy var timelbl:UILabel = {
        
        let lbl =  UILabel.init(title: "昵称", fontSize: 12, color: LIGHTGRAY_COLOR, screenInset: 10)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    //点赞
    private lazy var likeBtn:UIButton = {
        let btn = UIButton.init(title: "昵称", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: "ic_common_praise_normal", fontSize: 12, target: self, actionName: nil)
        
        btn.tag = 2
        
        
        return btn
    }()
    
    //分割线
    private lazy var grayView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
    
}
