//
//  CartoonTableView.swift
//  快看漫画
//
//  Created by Youcai on 16/8/16.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import SDWebImage
protocol CartoonTableViewDel:NSObjectProtocol {
    
    func didSelectedBtn(sender:UIButton,data:ModelData)
}
class CartoonTableView: UITableView {
    var user:User?
    var data:ModelData?
    weak var del:CartoonTableViewDel?
    
    var imageArray:[String]? {
        didSet {
            
            reloadData()
        }
    }
    lazy var commentsArray = [Comments]()
    lazy var imageInfo = [Image_infos]()
    // MARK: - 构造方法
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        separatorStyle = .none
        register(cartoonCell.self, forCellReuseIdentifier: "cell")
        register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        register(CartoonSectionFootView.self, forHeaderFooterViewReuseIdentifier: "foot")
        
        register(CommentSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        estimatedRowHeight = 400
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - 数据源/代理方法
extension CartoonTableView:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2//imageArray.count + commentsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  section == 0 ? (imageArray?.count ?? 0 ) : commentsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellID = "cell"
        cellID =  indexPath.section == 0 ?  "cell" : "CommentCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if indexPath.section == 0 {
            (cell as! cartoonCell).url = imageArray?[indexPath.row]
        }else {
            
            (cell as! CommentCell).data = commentsArray[indexPath.row]
            (cell as! CommentCell).nickname = data?.user?.nickname
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            let scale = Double(imageInfo[indexPath.row].width)/640.00
            return CGFloat(Double(imageInfo[indexPath.row].height)/scale/2)
        }else {
            
            return commentsArray.count > 0 ? commentsArray[indexPath.row].rowHeight : 0
        }
    }
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // del?.didSelectedCell()
    // }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CommentSectionHeaderView
            
            
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "foot") as! CartoonSectionFootView
            view.data = data
            view.btnClickBlcok(btnblock: {[weak self] (sender) in
                self?.del?.didSelectedBtn(sender: sender, data: (self?.data)!)
            })
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  section == 0 ? 0.1 : 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 225 : 0.1
    }
    
    
}
// MARK: - 自定义cell
fileprivate class cartoonCell:UITableViewCell {
    var url:String? {
        didSet {
            
            // 利用 SDWebImage 检查本地的缓存图像 - key 就是 url 的完整字符串
            // 问：SDWebImage 是如何设置缓存图片的文件名 完整 URL 字符串 -> `MD5`
            // if let key = viewModle?.thumbnailUrls?.first?.absoluteString {
            
            if let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: url!) {
                print("ff")
                imgView.image = image
                return
            }
            
            
            imgView.sd_setImage(with: URL.init(string: url!), placeholderImage: UIImage.init(named: "ic_common_placeholder_comic_detail"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            
        }
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate lazy var imgView:UIImageView = {
        let imgView = UIImageView()
        //  imgView.contentMode = .ScaleAspectFit
        return imgView
    }()
}
