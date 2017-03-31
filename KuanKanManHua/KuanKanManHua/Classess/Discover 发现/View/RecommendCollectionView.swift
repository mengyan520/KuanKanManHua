//
//  RecommendCollectionView.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/14.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
private let ID = "cell"
private let horizontalID = "horizontalcell"
private let verticalID = "verticalcell"
private let  bannerID = " bannercell"
class RecommendCollectionView: UICollectionView {
    var dataArray:[Topics]? {
        didSet {
            
            sizeToFit()
            reloadData()
        }
        
    }
    var bannersArray:[Banners]? {
        didSet {
            
            sizeToFit()
            reloadData()
        }
        
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        switch Int((index?.section)!) {
            
            
        case 0:
            layout!.scrollDirection = .horizontal
            return  CGSize.init(width: SCREEN_WIDTH, height: 180)
        case 1,4,12:
            
            layout!.scrollDirection = .horizontal
            return CGSize.init(width: SCREEN_WIDTH, height: 427*((SCREEN_WIDTH-40)/3.0)/320)
        case 2,3,5,6,8,9,10,11:
            layout!.collectionView?.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
            layout!.scrollDirection = .vertical
            return CGSize.init(width: SCREEN_WIDTH, height: (427*(((SCREEN_WIDTH-40)/3.0)/320)+50) * 2)
        default:
            break
            
        }
        
        layout!.scrollDirection = .vertical
        layout!.collectionView?.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        return CGSize.init(width: SCREEN_WIDTH, height: 60 +  25)
    }
    // MARK: - init
    
    init() {
        layout = UICollectionViewFlowLayout()
        
        super.init(frame:  CGRect.zero, collectionViewLayout: layout!)
        dataSource = self
        delegate  = self
        backgroundColor = WHITE_COLOR
        register(recommendCell.self, forCellWithReuseIdentifier: ID)
        register(horizontalCell.self, forCellWithReuseIdentifier: horizontalID)
        register(verticalCell.self, forCellWithReuseIdentifier: verticalID)
        register(verticalCell.self, forCellWithReuseIdentifier: bannerID)
        layout!.scrollDirection = .vertical
        layout!.collectionView?.contentInset = UIEdgeInsetsMake(0, 10, 0, 0)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
    }
    var layout:UICollectionViewFlowLayout?
    var index:IndexPath?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - 数据源/代理
extension RecommendCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index?.section == 7 {
            return 2
        }
        if index?.section == 0 {
            return 21
        }
        
        return dataArray!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if index?.section == 7 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerID, for: indexPath) as! verticalCell
            
            cell.bannerdata = bannersArray?[indexPath.row]
            
            return cell
        }else {
            if index?.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! recommendCell
                
                
                cell.topicsData(data: (dataArray?[indexPath.row])!, index: indexPath)
                return cell
            } else if (index?.section == 1 || index?.section == 4  || index?.section == 12)  {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: horizontalID, for: indexPath) as! horizontalCell
                
                
                cell.data = dataArray?[indexPath.row]
                return cell
                
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: verticalID, for: indexPath) as! verticalCell
                
                
                cell.data = dataArray?[indexPath.row]
                return cell
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        POSTNOTIFICATION(name: "wordDetail", data: ["data":dataArray![indexPath.item]])
    }
    
    //行 size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch index!.section {
        case 0:
            return CGSize.init(width: SCREEN_WIDTH-120, height: 180/3.0 )
            
        case 1,4,12:
            
            return CGSize.init(width: SCREEN_WIDTH-120, height: self.height)
        case 2,3,5,6,8,9,10,11:
            
            return CGSize.init(width: (SCREEN_WIDTH-40)/3.0, height: self.height/2)
        default:
            break
        }
        
        return CGSize.init(width: (SCREEN_WIDTH-30)/2.0, height: self.height )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// MARK: - 自定义Cell

fileprivate class recommendCell:UICollectionViewCell {
    
    func topicsData(data:Topics,index:IndexPath)  {
        
        
        
        if index.row == 20 {
            rowlbl.isHidden = true
            namelbl.isHidden = true
            titlelbl.isHidden = true
            iconView.isHidden = true
            bottomline.isHidden = true
        } else {
            rowlbl.isHidden = false
            namelbl.isHidden = false
            titlelbl.isHidden = false
            iconView.isHidden = false
            (index.row + 1) % 3 == 0 ? (bottomline.isHidden = false) : (bottomline.isHidden = true)
            
            iconView.sd_setImage(with: URL.init(string: (data.pic! + "-w320")), placeholderImage: UIImage.init(named: "ic_common_cell_bg"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            
            rowlbl.text = "\(index.row + 1) "
            titlelbl.text = (data.title)!
            
            
            namelbl.text =  (data.user?.nickname)!
            
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        backgroundColor = WHITE_COLOR
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(rowlbl)
        contentView.addSubview(titlelbl)
        contentView.addSubview(namelbl)
        contentView.addSubview(topline)
        contentView.addSubview(bottomline)
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(110)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        topline.snp.makeConstraints { (make) in
            
            make.top.right.equalTo(contentView)
            make.left.equalTo(iconView.snp.right)
            
            make.height.equalTo(0.5)
        }
        bottomline.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right)
            make.bottom.right.equalTo(contentView)
            make.height.equalTo(0.5)
            
        }
        
        rowlbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(5)
            make.top.equalTo(contentView.snp.top).offset(10)
            
        }
        titlelbl.snp.makeConstraints { (make) in
            make.left.equalTo(rowlbl.snp.right).offset(5)
            
            make.top.equalTo(rowlbl.snp.top)
            make.width.equalTo(contentView.width-110-20)
        }
        namelbl.snp.makeConstraints { (make) in
            make.left.equalTo(titlelbl.snp.left)
            make.top.equalTo(titlelbl.snp.bottom).offset(5)
            
            make.width.equalTo(contentView.width-110-20)
        }
    }
    
    private lazy var iconView:UIImageView = {
        let view = UIImageView.init()
        
        return view
    }()
    private lazy var titlelbl:UILabel = {
        let lbl = UILabel.init()
        lbl.textColor = BLACK_COLOR
        lbl.font = BFont(fontSize: 14)
        
        return lbl
    }()
    private lazy var namelbl:UILabel = {
        let lbl = UILabel.init()
        lbl.textColor = BLACK_COLOR
        lbl.font = Font(fontSize: 14)
        
        return lbl
    }()
    private lazy var rowlbl:UILabel = {
        let lbl = UILabel.init()
        lbl.textColor = RED_COLOR
        lbl.font = BFont(fontSize: 14)
        
        return lbl
    }()
    private lazy var topline:UIView = {
        let view = UIView.init()
        view.backgroundColor = RGB(r: 234, g: 234, b: 234, a: 1.0)
        
        
        return view
    }()
    private lazy var bottomline:UIView = {
        let view = UIView.init()
        view.backgroundColor = RGB(r: 234, g: 234, b: 234, a: 1.0)
        
        
        return view
    }()
}
fileprivate class horizontalCell:UICollectionViewCell {
    var data:Topics? {
        didSet {
            iconView.sd_setImage(with: URL.init(string: ((data?.pic!)! + "-w320")), placeholderImage: UIImage.init(named: "ic_common_cell_bg"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            titlelbl.text = data?.title
            
            
            namelbl.text =  data?.user?.nickname
            categoryLbl.text = data?.label_text
            categoryLbl.backgroundColor = UIColor.colorWithHexString(hex: (data?.label_color!)!)
            deslbl.text = data?.des
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        backgroundColor = WHITE_COLOR
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(deslbl)
        contentView.addSubview(titlelbl)
        contentView.addSubview(namelbl)
        contentView.addSubview(categoryLbl)
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(110)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        titlelbl.snp.makeConstraints { (make) in
            
            make.width.equalTo(contentView.width-110-20)
            make.left.equalTo(iconView.snp.right).offset(5)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        namelbl.snp.makeConstraints { (make) in
            make.left.equalTo(titlelbl.snp.left)
            make.top.equalTo(titlelbl.snp.bottom).offset(5)
            
            make.width.equalTo(contentView.width-110-20)
        }
        categoryLbl.snp.makeConstraints { (make) in
            make.left.equalTo(titlelbl.snp.left)
            make.top.equalTo(namelbl.snp.bottom).offset(5)
            
            
        }
        deslbl.snp.makeConstraints { (make) in
            make.left.equalTo(titlelbl.snp.left)
            make.top.equalTo(categoryLbl.snp.bottom).offset(5)
            make.width.equalTo(contentView.width-5-110-10)
        }
    }
    
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    private lazy var titlelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = BLACK_COLOR
        lbl.font = BFont(fontSize: 14)
        
        return lbl
    }()
    private lazy var namelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = BLACK_COLOR
        lbl.font = Font(fontSize: 14)
        
        return lbl
    }()
    private lazy var deslbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = BLACK_COLOR
        lbl.font = BFont(fontSize: 14)
        lbl.numberOfLines = 3
        return lbl
    }()
    fileprivate lazy var categoryLbl:UILabel = {
        let lbl = UILabel.init(title: "剧情", fontSize: 12, color: WHITE_COLOR, screenInset: 10)
        lbl.layer.cornerRadius = 5
        lbl.layer.masksToBounds = true
        return lbl
    }()
}
fileprivate class verticalCell:UICollectionViewCell {
    var data:Topics? {
        didSet {
            
            iconView.sd_setImage(with: URL.init(string: ((data?.pic!)! + "-w320")), placeholderImage: UIImage.init(named: "ic_common_cell_bg"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            
            titlelbl.text = data?.title
            
            if data?.recommended_text == "" {
                namelbl.text =  data?.user?.nickname
            }else {
                namelbl.text =  data?.recommended_text
            }
        }
    }
    var bannerdata:Banners? {
        didSet {
            iconView.snp.updateConstraints { (make) in
                make.height.equalTo(60)
            }
            iconView.sd_setImage(with: URL.init(string: ((bannerdata?.pic!)! + "-w320")), placeholderImage: UIImage.init(named: "ic_common_cell_bg"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
                
                
            }
            
            titlelbl.text = bannerdata?.target_title
            
            namelbl.isHidden = true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        backgroundColor = WHITE_COLOR
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI() {
        contentView.addSubview(iconView)
        
        contentView.addSubview(titlelbl)
        contentView.addSubview(namelbl)
        
        iconView.snp.makeConstraints { (make) in
            
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(contentView.height
                - 50)
            
        }
        titlelbl.snp.makeConstraints { (make) in
            
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.width.equalTo(contentView.width)
            make.left.equalTo(iconView.snp.left)
        }
        namelbl.snp.makeConstraints { (make) in
            make.top.equalTo(titlelbl.snp.bottom).offset(5)
            make.left.equalTo(titlelbl.snp.left)
            
            make.width.equalTo(contentView.width)
        }
        
    }
    
    private lazy var iconView:UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    private lazy var titlelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = BLACK_COLOR
        lbl.font = BFont(fontSize: 14)
        
        return lbl
    }()
    private lazy var namelbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = BLACK_COLOR
        lbl.font = Font(fontSize: 12)
        
        return lbl
    }()
    
    
}
