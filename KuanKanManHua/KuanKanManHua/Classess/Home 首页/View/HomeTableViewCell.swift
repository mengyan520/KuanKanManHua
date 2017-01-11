//
//  HomeTableViewCell.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/7.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import SDWebImage
protocol HomeTableViewCellDel:NSObjectProtocol {
    
    func didClickTopView(id:Int)
    func didBtnClick(sender:UIButton,data:Comics)
}
class HomeTableViewCell: UITableViewCell {
    weak var del:HomeTableViewCellDel?
    // MARK: - 行高
    func rowHeight(data:Comics) -> CGFloat  {
        self.data = data
        contentView.layoutIfNeeded()
        return bottomView.frame.maxY
    }
    // MARK: - set
    var data:Comics? {
        didSet {
            categoryLbl.text = data?.label_text
            categoryLbl.backgroundColor = UIColor.colorWithHexString(hex: (data?.label_color!)!)
            titleLbl.text = data?.topic?.title
            // authorBtn.setTitle(data?.topic?.user?.nickname, for: .normal)
            
            pictureView.sd_setImage(with: URL.init(string: (data?.cover_image_url)!), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            
            chapterLbl.text = data?.title
            likeBtn.setTitle(" \(data!.likes_count)", for: .normal)
            commentBtn.setTitle(" \(data!.comments_count)", for: .normal)
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
        contentView.addSubview(topView)
        topView.addSubview(categoryLbl)
        topView.addSubview(titleLbl)
        topView.addSubview(authorBtn)
        contentView.addSubview(pictureView)
        contentView.addSubview(chapterLbl)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(bottomView)
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.right.left.equalTo(contentView)
            make.height.equalTo(40)
        }
        
        categoryLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(topView.snp.centerY)
            make.left.equalTo(topView.snp.left).offset(5)
            
            make.width.equalTo(35)
            make.height.equalTo(15)
        }
        authorBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(categoryLbl.snp.centerY)
            make.right.equalTo(topView.snp.right).offset(-5)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLbl.snp.top)
            make.left.equalTo(categoryLbl.snp.right).offset(5)
        }
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalTo(contentView)
            make.height.equalTo(180);
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-5)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(commentBtn.snp.top)
            make.right.equalTo(commentBtn.snp.left).offset(-10)
            make.height.equalTo(commentBtn.snp.height)
        }
        chapterLbl.snp.makeConstraints { (make) in
            make.left.equalTo(categoryLbl.snp.left)
            make.centerY.equalTo(likeBtn.snp.centerY)
            make.width.equalTo(SCREEN_WIDTH/2.0)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(commentBtn.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.height.equalTo(5)
            // make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    // MARK: - action
    @objc private func topViewClick() {
    
     del?.didClickTopView(id: (data?.topic?.id)!)
    }
    @objc private func btnClick(sender:UIButton) {
        
        del?.didBtnClick(sender: sender, data: data!)
    }
    // MARK: - 懒加载
    private lazy var topView:UIView = {
        let view = UIView()
        view.backgroundColor = WHITE_COLOR
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.topViewClick))
        view.addGestureRecognizer(tap)
        return view
    }()
    private lazy var categoryLbl:UILabel = {
        let lbl = UILabel.init(title: "剧情", fontSize: 12, color: WHITE_COLOR, screenInset: 0)
        lbl.layer.cornerRadius = 7
        lbl.layer.masksToBounds = true
        return lbl
    }()
    private lazy var titleLbl:UILabel = {
        let lbl = UILabel.init(title: "标题", fontSize: 12, color: BLACK_COLOR, screenInset: 10)
        return lbl
    }()
    private lazy var authorBtn:UIButton = {
        let btn = UIButton.init(title: "全集", color:RGB(r: 59, g: 59, b: 59, a: 1.0), SelectedColor: nil, imageName: "ic_home_title", fontSize: 12, target: self, actionName: nil)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        
        
        return btn
    }()
    private lazy var pictureView:UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var chapterLbl:UILabel = {
        let lbl = UILabel.init(title: "分集", fontSize: 12, color: BLACK_COLOR, screenInset: 10)
        lbl.numberOfLines = 1
        return lbl
    }()
    private lazy var likeBtn:UIButton = {
    
        let btn = UIButton.init(title: "1", color: LIGHTGRAY_COLOR, SelectedColor: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_home_praise", SelectedImageName: "ic_home_praise_highlighted", fontSize: 12 , target: self, actionName: #selector(self.btnClick(sender:)))
         btn.tag = 1
        return btn
    }()
    private lazy var commentBtn:UIButton = {
        
        let btn = UIButton.init(title: "评论", color: LIGHTGRAY_COLOR, SelectedColor: RGB(r: 255, g: 209, b: 10, a: 1.0), imageName: "ic_home_details", SelectedImageName: "ic_home_details_highlighted", fontSize: 12 , target: self, actionName: #selector(self.btnClick(sender:)))
        btn.tag = 2
        return btn
    }()
    private lazy var bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = WHcolor
        return view
    }()
}
