//
//  HomeTableViewCell.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/7.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import SDWebImage
class HomeTableViewCell: UITableViewCell {
    // MARK: - 行高
    func rowHeight(data:Comics) -> CGFloat  {
        self.data = data
        contentView.layoutIfNeeded()
        return bottomView.frame.maxY
    }
    // MARK: - set
    var data:Comics? {
        didSet {
            cateoryLbl.text = data?.label_text
            cateoryLbl.backgroundColor = UIColor.colorWithHexString(hex: (data?.label_color!)!)
            titleLbl.text = data?.topic?.title
            authorBtn.setTitle(data?.topic?.user?.nickname, for: .normal)
            
            pictureView.sd_setImage(with: URL.init(string: (data?.cover_image_url)!), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
//                let img = image?.scaleToWith(width: SCREEN_WIDTH)
//                
//                self.pictureView.image = img
//                self.pictureView.snp.updateConstraints({ (make) in
//                    make.height.equalTo((img?.size.height)!)
//                })
            }
          
            chapterLbl.text = data?.title
            likeBtn.setTitle("\(data!.likes_count)", for: .normal)
            commentBtn.setTitle("\(data!.comments_count)", for: .normal)
        }
    }
    // MARK: - init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = WHITE_COLOR
        setUI()
        
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
    // MARK: - setUI
    func setUI()   {
        contentView.addSubview(cateoryLbl)
        contentView.addSubview(titleLbl)
        contentView.addSubview(authorBtn)
        contentView.addSubview(pictureView)
        contentView.addSubview(chapterLbl)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(bottomView)
        
        authorBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
        }
        cateoryLbl.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(5)
            make.centerY.equalTo(authorBtn.snp.centerY)
            
        }
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(cateoryLbl.snp.top)
            make.left.equalTo(cateoryLbl.snp.right).offset(5)
        }
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(cateoryLbl.snp.bottom).offset(5)
            make.left.right.equalTo(contentView)
            make.height.equalTo(180);
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(commentBtn.snp.top)
            make.right.equalTo(commentBtn.snp.left).offset(-5)
        }
        chapterLbl.snp.makeConstraints { (make) in
            make.left.equalTo(cateoryLbl.snp.left)
            make.centerY.equalTo(likeBtn.snp.centerY)
            make.width.equalTo(SCREEN_WIDTH/2.0)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(commentBtn.snp.bottom).offset(5)
            make.left.right.equalTo(contentView)
            make.height.equalTo(5)
           // make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    // MARK: - Get
    fileprivate lazy var cateoryLbl:UILabel = {
        let lbl = UILabel.init(title: "剧情", fontSize: 12, color: WHITE_COLOR, screenInset: 10)
        lbl.layer.cornerRadius = 5
        lbl.layer.masksToBounds = true
        return lbl
    }()
    fileprivate lazy var titleLbl:UILabel = {
        let lbl = UILabel.init(title: "标题", fontSize: 12, color: BLACK_COLOR, screenInset: 10)
        return lbl
    }()
    fileprivate lazy var authorBtn:UIButton = {
        let btn = UIButton.init(title: "作者", color: BLACK_COLOR, SelectedColor: nil, imageName: nil, fontSize: 12, target: self, actionName: nil)
        return btn
    }()
    fileprivate lazy var pictureView:UIImageView = {
        let view = UIImageView.init()
        return view
    }()
    fileprivate lazy var chapterLbl:UILabel = {
        let lbl = UILabel.init(title: "分集", fontSize: 12, color: BLACK_COLOR, screenInset: 10)
        lbl.numberOfLines = 1
        return lbl
    }()
    fileprivate lazy var likeBtn:UIButton = {
        let btn = UIButton.init(title: "喜欢", color: BLACK_COLOR, SelectedColor: nil, imageName: nil, fontSize: 12, target: self, actionName: nil)
        return btn
    }()
    fileprivate lazy var commentBtn:UIButton = {
        let btn = UIButton.init(title: "评论", color: BLACK_COLOR, SelectedColor: nil, imageName: nil, fontSize: 12, target: self, actionName: nil)
        return btn
    }()
    private lazy var bottomView:UIView = {
        let view = UIView.init()
        view.backgroundColor = WHcolor
        return view
    }()
}
