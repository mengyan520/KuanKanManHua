//
//  AuthorLeftCell.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/3/1.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class AuthorLeftCell: UITableViewCell {
    var data:Topics? {
        didSet {
            iconView.sd_setImage(with: URL.init(string: data!.cover_image_url!), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
           
            titlelbl.text = data?.title
            infolbl.text  = data?.des
        
        
        }
    
    }
    // MARK: - init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        
    }
    private func setUI() {
        //640 * 400
        contentView.addSubview(iconView)
        contentView.addSubview(titlelbl)
        contentView.addSubview(infolbl)
        iconView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.width.equalTo(128)
            make.height.equalTo(80)
            
        }
        
        titlelbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(SCREEN_WIDTH-128-30-55)
            
            
        }
        infolbl.snp.makeConstraints { (make) in
             make.bottom.equalTo(iconView.snp.bottom).offset(-5)
             make.left.equalTo(titlelbl.snp.left)
             make.right.equalTo(contentView.snp.right).offset(-10)
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
    //MARK: - 懒加载
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    private lazy var titlelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = BLACK_COLOR
        lbl.font = BFont(fontSize: 16)
        lbl.text = "标题"
        return lbl
    }()
    private lazy var infolbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = LIGHTGRAY_COLOR
        lbl.font = Font(fontSize: 12)
        lbl.text = "作者"
        lbl.numberOfLines = 3
        return lbl
    }()
}
