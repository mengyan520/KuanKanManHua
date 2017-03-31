//
//  RightTableViewCell.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/17.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {

    var data:Author_list? {
        didSet {
            let url =   ((data?.avatar_url)! as NSString).replacingOccurrences(of: "w180.w", with: "w180")
            
            iconView.sd_setImage(with: URL.init(string: url), placeholderImage:UIImage.init(named: "ic_personal_headportrait"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            namelbl.text = data?.nickname
            bomlbl.text = data?.u_intro
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
        contentView.addSubview(idView)
        contentView.addSubview(namelbl)
        contentView.addSubview(bomlbl)
        
        contentView.addSubview(bottomView)
        iconView.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
            
        }
        idView.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        namelbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top).offset(10)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH-60-10)
        }
        bomlbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(namelbl.snp.left)
            make.width.equalTo(SCREEN_WIDTH-60-10)
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
    //头像
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    //标识
    private lazy var idView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "ic_details_top_auther_headportrait_v")
        return view
    }()

    private lazy var namelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = RGB(r: 245, g: 101, b: 7, a: 1.0)
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
