//
//  RecommendTableView.swift
//  快看漫画
//
//  Created by Youcai on 16/7/28.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
private let ID = "tableCell"
private let HeaderId = "HeaderId"
protocol bannersViewDel:NSObjectProtocol {
    func didSelectedbannersView(banners:Banners)
}
class RecommendTableView: UITableView {
    lazy var dataArray = [Infos]()
    var bannerArray:[Banners]? {
        didSet {
            
            
            bannersView.stopAutoRun()
            bannersView.reloadDate()
            bannersView.startAutoRun()
        }
    }
   weak var del:bannersViewDel?
    // MARK: - 构造方法
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        separatorStyle = .none
        register(TableCell.self, forCellReuseIdentifier: ID)
        
        register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderId)
        contentInset = UIEdgeInsetsMake(SCREEN_WIDTH/(1280/600), 0, 0, 0)
        
        addSubview(bannersView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate lazy var bannersView:CarouselView = {
        let view = CarouselView.init(frame: CGRect.init(x: 0, y: -SCREEN_WIDTH/(1280/600), width: SCREEN_WIDTH, height: SCREEN_WIDTH/(1280/600)))
        
        view.dataSource = self
        view.delegate = self
        view.timeInterval = 4
        view.backgroundColor = WHITE_COLOR
        return view
        
    }()
}
// MARK: -  数据源/代理方法
extension RecommendTableView:UITableViewDataSource,UITableViewDelegate,CarouselDelegate,CarouselDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! TableCell
        if dataArray[indexPath.section].topics == nil {
            cell.topicsData(data: nil,bannerdata:dataArray[indexPath.section].banners!, index: indexPath)
        }else {
            cell.topicsData(data: dataArray[indexPath.section].topics!,bannerdata:nil, index: indexPath)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return  180+15
        case 1,4,12:
            return  427*((SCREEN_WIDTH-40)/3.0)/320 + 15
        case 2,3,5,6,7,9,10,11:
            return  ((427*((SCREEN_WIDTH-40)/3.0)/320)+50) * 2 + 15
            
        default:
            break
        }
        return 60 +  25 + 15
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderId) as! HeaderView
        view.data = dataArray[section]
        return view
    }
    
    //轮播
    func numberOfPages(carouselView: CarouselView) -> NSInteger {
        
        return (bannerArray?.count)!
    }
    func carouselView(carouselView: CarouselView, index: NSInteger) -> UIView {
        let imageView = UIImageView(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: bannersView.height))
        
        
        imageView.sd_setImage(with: URL.init(string: (bannerArray![index].pic! + "-w320")), placeholderImage: UIImage.init(named: "ic_common_placeholder_banner"), options: [.retryFailed,.refreshCached]) { (image, error, type, url) in
            
            
        }
        
        return imageView
    }
    func didSelectedcarouselView(carouselView: CarouselView, index: NSInteger) {
        del?.didSelectedbannersView(banners:bannerArray![index])
    }
}
// MARK: - 自定义cell
private class TableCell:UITableViewCell {
    
    
    
    func topicsData(data:[Topics]?,bannerdata:[Banners]?,index:IndexPath) {
        
        pictureView.index = index
        data == nil ? (pictureView.bannersArray = bannerdata) :(pictureView.dataArray = data)
        
        
        pictureView.snp.updateConstraints { (make) -> Void in
            
            make.height.equalTo(pictureView.bounds.height)
            // 直接设置宽度数值
            make.width.equalTo(pictureView.bounds.width)
        }
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(pictureView)
        contentView.addSubview(bottomView)
        pictureView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
            
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(pictureView.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.height.equalTo(5)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //懒加载
    //图片
    private lazy var pictureView:RecommendCollectionView = {
        let view = RecommendCollectionView.init()
        
        
        return view
    }()
    private lazy var bottomView:UIView = {
        let view = UIView.init()
        view.backgroundColor = WHcolor
        return view
    }()
}
fileprivate class HeaderView:UITableViewHeaderFooterView {
    var data:Infos? {
        didSet {
            titlelbl.text = data?.title
            if titlelbl.text == "每周点击排行榜" {
                rightBtn.setImage(UIImage.init(named: "ic_discover_time"), for: .normal)
            }else {
                rightBtn.setImage(UIImage.init(named: "ic_discover_more"), for: .normal)
                rightBtn.setImage(UIImage.init(named: "ic_discover_more_pressed"), for: .highlighted)
            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = WHITE_COLOR
        setUI()
    }
    func setUI() {
        contentView.addSubview(yellowView)
        contentView.addSubview(titlelbl)
        contentView.addSubview(rightBtn)
        yellowView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
        titlelbl.snp.makeConstraints { (make) in
            make.left.equalTo(yellowView.snp.right).offset(5)
            make.centerY.equalTo(self.snp.centerY)
            
        }
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //懒加载
    private lazy var yellowView:UIView = {
        let view = UIView()
        view.backgroundColor = mainColor
        view.layer.cornerRadius = 4
        return view
    }()
    private lazy var titlelbl:UILabel = {
        let lbl = UILabel.init(title: "标题", fontSize: 14, color: BLACK_COLOR, screenInset: 0)
        
        return lbl
    }()
    private lazy var rightBtn:UIButton = {
        let btn = UIButton.init()
        // btn.addTarget(self, action: nil, for: .touchUpInside)
        return btn
    }()
    
}
