//
//  CategoryCell.swift
//  KuanKanManHua
//
//  Created by 马鸣 on 2016/12/16.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    func rowHeight(data: Topics) -> CGFloat {
        
        self.data = data
        
        
        contentView.layoutIfNeeded()
        
        
        return bottomView.frame.maxY
    }

    var data:Topics? {
        didSet {
            iconView.sd_setImage(with: URL.init(string: data!.cover_image_url!), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
        
            titlelbl.text = data?.title
            namelbl.text = data?.user?.nickname
            
            if data!.likes_count > 10000 {
                likeBtn.setTitle(" \((data!.likes_count)/10000)万", for: .normal)
            }else {
                likeBtn.setTitle(" \(data!.likes_count)", for: .normal)
            }
            if data!.comments_count > 100000 {
                commentBtn.setTitle(" \((data!.comments_count)/100000)万", for: .normal)
            }else {
                commentBtn.setTitle(" \(data!.comments_count)", for: .normal)
            }
        }
    }
   

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    func setUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(titlelbl)
        contentView.addSubview(namelbl)
        contentView.addSubview(followBtn)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(bottomView)
        iconView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(80)
            
        }
        followBtn.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
        }
        titlelbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top).offset(10)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH-120-30-55)

            
        }
        namelbl.snp.makeConstraints { (make) in
            make.top.equalTo(titlelbl.snp.bottom).offset(5)
            make.left.equalTo(titlelbl.snp.left)
            make.width.equalTo(SCREEN_WIDTH/2)        }
        
        likeBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconView.snp.bottom).offset(-2)
            make.left.equalTo(titlelbl.snp.left)
        }
        commentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(likeBtn.snp.top)
            make.left.equalTo(likeBtn.snp.right).offset(20)
            make.bottom.equalTo(iconView.snp.bottom).offset(-2)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.height.equalTo(0.5)
          //  make.bottom.equalTo(contentView.snp.bottom)
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
    // MARK: - 点击事件
    
    func  btnClick(sender:UIButton)  {
       
            POSTNOTIFICATION(name: "login", data: nil)
        
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
        lbl.textColor = BLACK_COLOR
        lbl.font = Font(fontSize: 14)
        lbl.text = "作者"
        return lbl
    }()
    private lazy var followBtn:UIButton = {
        let btn = UIButton.init(imageName: "ic_feed_cell_follow_normal", backImageName: nil, highlightedImageName: nil, target: self, actionName: #selector(self.btnClick(sender:)))
        
        
        return btn
    }()
    private lazy var likeBtn:UIButton = {
        let btn = UIButton.init(title: "1", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: "ic_common_praise_normal", fontSize: 12, target: self, actionName: nil)
       
        
        return btn
    }()
    private lazy var commentBtn:UIButton = {
        let btn =  UIButton.init(title: "1", color: LIGHTGRAY_COLOR, SelectedColor: nil, imageName: "ic_common_comment_normal", fontSize: 12, target: self, actionName: nil)
       
        
        return btn
    }()
    private lazy var bottomView:UIView = {
        let view = UIView()
       view.backgroundColor = WHcolor
        return view
    }()
}
