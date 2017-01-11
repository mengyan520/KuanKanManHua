//
//  CommentCell.swift
//  快看漫画
//
//  Created by Youcai on 16/7/26.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    var nickname:String? {
        didSet {
            
            if data?.user?.nickname == nickname {
                idView.isHidden = false
            }else {
                idView.isHidden = true
            }
        }
    }
    // MARK: - 模型赋值
    var data:Comments? {
        didSet {
            let url =   ((data?.user?.avatar_url)! as NSString).replacingOccurrences(of: "w180.w", with: "w180")
            iconView.sd_setImage(with: URL.init(string: url), placeholderImage:UIImage.init(named: "ic_personal_headportrait"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            
            
            namelbl.text = data?.user!.nickname
            contentlbl.text = data?.content
            timelbl.text = Date.init().timeStringWithInterval(time: TimeInterval(data!.created_at * 1000))
           
            if data!.likes_count == 0 {
                likeBtn .setTitle("  ", for: .normal)
            }else {
                likeBtn .setTitle("  \(data!.likes_count)", for: .normal)
                
            }
            
            
        }
    }
    
    func rowHeight(data: Comments) -> CGFloat {
        
        self.data = data
        
        
        contentView.layoutIfNeeded()
        
        
        return grayView.frame.maxY
    }
    
    
    // MARK: - 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -  设置界面
    private func setUI() {
        contentView.addSubview(iconView)
        
        contentView.addSubview(namelbl)
        contentView.addSubview(idView)
        contentView.addSubview(contentlbl)
        contentView.addSubview(replyBtn)
        contentView.addSubview(timelbl)
        contentView.addSubview(likeBtn)
        contentView.addSubview(reportBtn)
        contentView.addSubview(grayView)
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
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(24)
        }
        
        
        timelbl.snp.makeConstraints { (make) in
            make.top.equalTo(namelbl.snp.bottom)
            make.left.equalTo(namelbl.snp.left)
            make.width.equalTo(SCREEN_WIDTH-20)
            
            
        }
        contentlbl.snp.makeConstraints { (make) in
            make.top.equalTo(timelbl.snp.bottom).offset(10)
            make.left.equalTo(namelbl.snp.left)
            make.width.equalTo(SCREEN_WIDTH-75)
            
        }
        replyBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentlbl.snp.bottom).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-20)
            //make.width.equalTo(24)
            
        }
        reportBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentlbl.snp.bottom).offset(10)
            make.left.equalTo(namelbl.snp.left)
           
            
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentlbl.snp.bottom).offset(16)
            make.right.equalTo(replyBtn.snp.left).offset(-10)
           // make.width.equalTo(80)
            
        }
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(reportBtn.snp.bottom)
            make.left.right.equalTo(contentView)
            
            make.height.equalTo(1)
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // MARK: - 点击事件
    func  btnClick(sender:UIButton)  {
        
    }
    // MARK: - 懒加载
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
        view.isHidden = true
        return view
    }()
    //昵称
    private lazy var namelbl:UILabel = {
        
        let lbl = UILabel.init(title: "昵称", fontSize: 12, color: LIGHTGRAY_COLOR, screenInset: 10)
        return lbl
    }()
    //时间
    private lazy var timelbl:UILabel = {
        let lbl = UILabel.init(title: "昵称", fontSize: 12, color: LIGHTGRAY_COLOR, screenInset: 10)
        return lbl
    }()
    //正文
    private lazy var contentlbl:UILabel = {
        
        let lbl = UILabel.init(title: "昵称", fontSize: 14, color: BLACK_COLOR, screenInset: 10)
        return lbl
    }()
    //点赞
    private lazy var likeBtn:UIButton = {
        let btn = UIButton.init(title: "昵称", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: "ic_common_praise_normal", fontSize: 12, target: self, actionName: nil)
        return btn
    }()
    //回复
    private lazy var replyBtn:UIButton = {
        
        let btn = UIButton.init(title: "回复", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: nil, fontSize: 12, target: self, actionName: nil)
        return btn
    }()
    //举报
    private lazy var reportBtn:UIButton = {
        
        let btn = UIButton.init(title: "举报", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: nil, fontSize: 12, target: self, actionName: nil)
        return btn
    }()
    //分割线
    private lazy var grayView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
}
