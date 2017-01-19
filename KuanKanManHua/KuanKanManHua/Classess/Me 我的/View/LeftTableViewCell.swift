//
//  LeftTableViewCell.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/17.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {
    var data:Topics? {
        didSet {
            
            iconView.sd_setImage(with: URL.init(string: data!.cover_image_url!), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            
            titlelbl.text = data?.title
            namelbl.text = data?.user?.nickname
            bomlbl.text = data?.latest_comic_title
        }
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(titlelbl)
        contentView.addSubview(namelbl)
        contentView.addSubview(bomlbl)
        
        contentView.addSubview(bottomView)
        iconView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(80)
            
        }
        
        titlelbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top).offset(10)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH-120-30-55)
            
            
        }
        namelbl.snp.makeConstraints { (make) in
            make.top.equalTo(titlelbl.snp.bottom).offset(5)
            make.left.equalTo(titlelbl.snp.left)
            make.width.equalTo(SCREEN_WIDTH/2)
        }
        bomlbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(titlelbl.snp.left)
            make.width.equalTo(SCREEN_WIDTH/2)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.height.equalTo(0.5)
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 懒加载
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    private lazy var titlelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = BLACK_COLOR
        lbl.font = BFont(fontSize: 14)
        lbl.text = "标题"
        return lbl
    }()
    private lazy var namelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = RGB(r: 59, g: 59, b: 59, a: 1.0)
        lbl.font = Font(fontSize: 12)
        lbl.text = "作者"
        return lbl
    }()
    private lazy var bomlbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = RGB(r: 59, g: 59, b: 59, a: 1.0)
        lbl.font = Font(fontSize: 12)
        lbl.text = "作者"
        return lbl
    }()
    
    
    private lazy var bottomView:UIView = {
        let view = UIView.init()
        view.backgroundColor = WHcolor
        return view
    }()
    
}
