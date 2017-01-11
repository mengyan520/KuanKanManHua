//
//  CommunityTableViewCell.swift
//  快看漫画
//
//  Created by Youcai on 16/7/22.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import SDWebImage
class CommunityTableViewCell: UITableViewCell {
    //定义回调
    typealias btnBlcok = (_ sender: UIButton) -> Void
    
    // MARK: - 模型赋值
    var data:Feeds? {
        didSet {
            let url =   ((data?.user?.avatar_url)! as NSString).replacingOccurrences(of: "w180.w", with: "w180")
            
            iconView.sd_setImage(with: URL.init(string: url), placeholderImage:UIImage.init(named: "ic_personal_headportrait"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            namelbl.text = data?.user!.nickname
            contentlbl.text = data?.content!.text
            timelbl.text = Date.init().timeStringWithInterval(time: TimeInterval(data!.created_at))
            likeBtn .setTitle("  \(data!.likes_count)", for: .normal)
            commentBtn .setTitle("  \(data!.comments_count)", for: .normal)
            pictureView.data = data?.content
            
            pictureView.snp.updateConstraints { (make) -> Void in
                var  offset =  0
                if ((data?.content?.images) != nil) {
                    offset = 10
                }
                make.top.equalTo(contentlbl.snp.bottom).offset(offset)
                make.height.equalTo(pictureView.bounds.height)
                // 直接设置宽度数值
                make.width.equalTo(pictureView.bounds.width)
            }
            
        }
        
    }
    
    // MARK: - 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rowHeight(data: Feeds) -> CGFloat {
        
        self.data = data
        
        
        contentView.layoutIfNeeded()
        
        return grayView.frame.maxY
    }
    
    // MARK: -  设置界面
    private func setUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(idView)
        contentView.addSubview(namelbl)
        contentView.addSubview(followBtn)
        contentView.addSubview(contentlbl)
        contentView.addSubview(pictureView)
        contentView.addSubview(timelbl)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
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
            make.centerY.equalTo(iconView.snp.centerY)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH/2)
            make.height.equalTo(24)
        }
        followBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-10)
            
        }
        contentlbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.left.equalTo(iconView.snp.left)
            make.width.equalTo(SCREEN_WIDTH-20)
            
        }
        pictureView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentlbl.snp.bottom)
            make.left.equalTo(contentlbl.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
            
        }
        timelbl.snp.makeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(10)
            make.left.equalTo(iconView.snp.left)
            make.width.equalTo(SCREEN_WIDTH-20)
            
            
        }
        commentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.width.equalTo(80)
            
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(10)
            make.right.equalTo(commentBtn.snp.left).offset(10)
            make.width.equalTo(80)
            
        }
        grayView.snp.makeConstraints { (make) in
            make.top.equalTo(timelbl.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            
            make.height.equalTo(1)
        }
    }
    // MARK: - 点击事件
    
    func  btnClick(sender:UIButton)  {
        if sender.tag == 1 {
             POSTNOTIFICATION(name: "login", data: nil)
        } else {
            
            POSTNOTIFICATION(name: "comment", data: ["data":data!])
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
    // MARK: - 懒加载
    //头像
    private lazy var iconView:UIImageView = {
        let view = UIImageView.init()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    //标识
    private lazy var idView:UIImageView = {
        let view = UIImageView.init()
        view.image = UIImage.init(named: "ic_details_top_auther_headportrait_v")
        return view
    }()
    //关注
    private lazy var followBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_feed_cell_follow_normal", backImageName: nil, SelectedImageName: nil, target: self, actionName: #selector(btnClick(sender:)))
        
        
        
        btn.tag = 1
        
        return btn
    }()
    //昵称
    private lazy var namelbl:UILabel = {
        
        let lbl = UILabel.init(title: "昵称", fontSize: 12, color: RGB(r: 245, g: 101, b: 7, a: 1.0), screenInset: 10)
        return lbl
    }()
    //正文
    private lazy var contentlbl:UILabel = {
        let lbl = UILabel.init(title: "正文", fontSize: 14, color: BLACK_COLOR, screenInset: 10)
        return lbl
    }()
    //图片
    private lazy var pictureView:CommunityPictureView = {
        let view = CommunityPictureView.init()
        
        
        return view
    }()
    //时间
    private lazy var timelbl:UILabel = {
        
        let lbl = UILabel.init(title: "正文", fontSize: 12, color: LIGHTGRAY_COLOR, screenInset: 10)
        return lbl
    }()
    //点赞
    private lazy var likeBtn:UIButton = {
        let btn = UIButton.init(title: "1", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: "ic_common_praise_normal", fontSize: 12, target: self, actionName: #selector(btnClick(sender:)))
        btn.tag = 2
        
        
        return btn
    }()
    //评论
    private lazy var commentBtn:UIButton = {
        let btn =  UIButton.init(title: "1", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: "ic_common_comment_normal", fontSize: 12, target: self, actionName: #selector(btnClick(sender:)))
        
        
        
        
        btn.tag = 3
        
        return btn
    }()
    //分割线
    private lazy var grayView:UIView = {
        let view = UIView.init()
        view.backgroundColor = WHcolor
        return view
    }()
}
