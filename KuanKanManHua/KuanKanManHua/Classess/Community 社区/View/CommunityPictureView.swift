//
//   PictureView.swift
//  Weibo10
//
//  Created by male on 15/10/20.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit
import SDWebImage
import MJPhotoBrowser
/// 照片之间的间距
private let PictureViewItemMargin: CGFloat = 5
/// 可重用表示符号
private let  PictureCellId = " PictureCellId"

/// 配图视图
class CommunityPictureView: UICollectionView {
    var data:Content?{
        didSet {
            
            // 自动计算大小
            sizeToFit()
            
            // 刷新数据 － 如果不刷新，后续的 collectionView 一旦被复用，不再调用数据源方法
            reloadData()
        }
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return calcViewSize()
    }
    
    // MARK: - 构造函数
    init() {
        let layout = UICollectionViewFlowLayout()
        
        // 设置间距 － 默认 itemSize 50 * 50
        layout.minimumInteritemSpacing =  PictureViewItemMargin
        layout.minimumLineSpacing =  PictureViewItemMargin
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = WHITE_COLOR
        
        // 设置数据源 - 自己当自己的数据源
        dataSource = self
        // 设置代理
        delegate = self
        
        // 注册可重用 cell
        register( PictureViewCell.self, forCellWithReuseIdentifier:  PictureCellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension CommunityPictureView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  (data?.images?.count) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: PictureCellId, for: indexPath) as!  PictureViewCell
        
        cell.imageURL = URL.init(string:(data?.image_base)! +  (data?.images![indexPath.item])! )
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! PictureViewCell
        let brower = MJPhotoBrowser.init()
        let photos = NSMutableArray()
        for i in 0..<data!.images!.count {
            
            let photo = MJPhoto.init()
          
            photo.url = URL.init(string:(data?.image_base)! +  (data?.images![i])!)
            photo.srcImageView = cell.iconView
            photos.add(photo)
        }
        
        brower.photos = photos as [AnyObject]
        brower.currentPhotoIndex = UInt(indexPath.item)
        
        brower.show()
    
        
    }
}


// MARK: - 计算视图大小
extension CommunityPictureView {
    
    /// 计算视图大小
    fileprivate func calcViewSize() -> CGSize {
        
        // 1. 准备
        // 每行的照片数量
        let rowCount: CGFloat = 3
        // 最大宽度
        let maxWidth = UIScreen.main.bounds.width - 2 *  10
        let itemWidth = (maxWidth - 2 *  PictureViewItemMargin) / rowCount
        
        // 2. 设置 layout 的 itemSize
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        // 3. 获取图片数量
        let count =  data?.images?.count ?? 0
        
        
        // 计算开始
        // 1> 没有图片
        if count == 0 {
            return .zero
        }
        
        // 2> 一张图片
        if count == 1 {
           let size = CGSize(width: (SCREEN_WIDTH - 5 * 2)*0.66, height:  (SCREEN_WIDTH - 5 * 2)*0.66 + 0.01) 
            
                       
            // 内部图片的大小
            layout.itemSize = size
            
            // 配图视图的大小
            return size
        }
        
        // 3> 四张图片 2 * 2 的大小
        if count == 4 {
            let w = 2 * itemWidth +  PictureViewItemMargin
            
            return CGSize(width: w, height: w)
        }
        
        // 4> 其他图片 按照九宫格来显示
        // 计算出行数
        /**
         2 3
         5 6
         7 8 9
         */
        let row = CGFloat((count - 1) / Int(rowCount) + 1)
        let h = row * itemWidth + (row - 1) *  PictureViewItemMargin
        let w = rowCount * itemWidth + (rowCount - 1) *  PictureViewItemMargin
        
        return CGSize(width: w, height: h)
    }
}

// MARK: - 配图 cell
private class  PictureViewCell: UICollectionViewCell {
    
    var imageURL: URL? {
        didSet {
          //  print(imageURL)
            iconView.sd_setImage(with: imageURL ,
                                        placeholderImage: UIImage.init(named: "ic_common_cell_bg"),                      // 在调用 OC 的框架时，可/必选项不严格
                options: [SDWebImageOptions.retryFailed,    // SD 超时时长 15s，一旦超时会记入黑名单
                    SDWebImageOptions.refreshCached])       // 如果 URL 不变，图像变
            
                    }
        
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 1. 添加控件
        contentView.addSubview(iconView)
       
        iconView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    // MARK: - 懒加载控件
    fileprivate lazy var iconView: UIImageView = {
        let iv = UIImageView()
        
        // 设置填充模式
        iv.contentMode = UIViewContentMode.scaleAspectFill
        // 需要裁切图片
        iv.clipsToBounds = true
        
        return iv
    }()
   
}

