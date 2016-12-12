//
//  CarouselView.swift
//  youCai
//
//  Created by Youcai on 16/3/7.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

protocol CarouselDataSource:NSObjectProtocol {
    //轮播的数量
    func numberOfPages(carouselView:CarouselView)->NSInteger
    //轮播的视图
    func carouselView(carouselView:CarouselView,index:NSInteger)->UIView
}
@objc
protocol CarouselDelegate:NSObjectProtocol {
    //点击事件
    @objc optional func didSelectedcarouselView(carouselView:CarouselView,index:NSInteger)
}
class CarouselView: UIView {
    // MARK: - 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame:self.bounds)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.contentOffset = CGPoint(x:self.bounds.size.width,y: 0)
        
        scrollView.contentSize = CGSize(width:self.bounds.size.width * 3,height:self.bounds.size.height)
        scrollView.delegate = self
        
        return scrollView
    }()
    lazy var pageIndicator:UIPageControl = {
        let page = UIPageControl(frame: CGRect(x:0, y:self.bounds.size.height-30,width: self.bounds.size.width,height: 30))
        page.pageIndicatorTintColor =  UIColor.init(white: 0.85, alpha: 1.0)
        page.currentPageIndicatorTintColor = WHITE_COLOR
        return page
    }()
    var pages :NSInteger = 0
    var currentPage:NSInteger = 0
    var contentViews = NSMutableArray()
    var timer:Timer? //= NSTimer()
    var timeInterval:TimeInterval = 0
   
    //代理属性
    weak var dataSource: CarouselDataSource?
    weak var delegate: CarouselDelegate?
}
// MARK: - 设置界面
extension CarouselView {
    func config() {
       
        addSubview(scrollView)
        addSubview(pageIndicator)
        contentViews = NSMutableArray(capacity: 4)
    }
}
// MARK: - 代理方法
extension CarouselView:UIScrollViewDelegate {
    //正在滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
       
        if x >= (self.bounds.size.width * 2) {
           
            self.currentPage = pageAtIndex(index:  self.currentPage + 1)
            loadData()
            
        }
        if x <= 0 {
             self.currentPage =  pageAtIndex(index:  self.currentPage - 1)
            loadData()
            
        }
    }
    //开始滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        resetTimer()
        //stopAutoRun()
    }
    //停止滚动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        resetTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x:self.frame.size.width,y: 0), animated: true)
    }
}
//MARK: - 刷新数据方法
extension CarouselView {
    func reloadDate() {
        pages = (dataSource?.numberOfPages(carouselView: self))!
        pageIndicator.numberOfPages = pages
        
        if pages != 0 {
            loadData()
        }
    }
    // load data
    func loadData() {
        clearSubView(view: scrollView)
        getDisplayViews(curPage: currentPage)
        for i in 0 ..< 3 {
           
            let view:UIView = contentViews.object(at: i) as! UIView
            view.isUserInteractionEnabled = true
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CarouselView.handleTap(tap:)))
            view.frame = view.frame.offsetBy(dx: view.frame.size.width * CGFloat(i), dy: 0)
            view.addGestureRecognizer(tap)
            scrollView.addSubview(view)
        }
        scrollView.contentOffset = CGPoint(x:self.frame.size.width,y: 0)
        pageIndicator.currentPage = currentPage
    }
    // clear subviews
    func clearSubView(view:UIView) {
        for temp:UIView in view.subviews {
            temp.removeFromSuperview()
        }
    }
    //get display views
    func getDisplayViews(curPage:NSInteger) {
        
        let pre = pageAtIndex(index: curPage - 1)
        let next = pageAtIndex(index: curPage + 1)
        if contentViews.count != 0 {
            contentViews.removeAllObjects()
        }
        contentViews.add((dataSource?.carouselView(carouselView: self, index: pre))!)
        contentViews.add((dataSource?.carouselView(carouselView: self, index: curPage))!)
        contentViews.add((dataSource?.carouselView(carouselView: self, index: next))!)
    }
    // get page index
    func pageAtIndex(index:NSInteger)->NSInteger {
          var tag = index
        if index == -1 {
            tag = pages - 1
        }
        if index == pages {
            tag = 0
        }
       
        return tag
    }
    // handle tap gesture
    func handleTap(tap:UITapGestureRecognizer) {
        delegate?.didSelectedcarouselView?(carouselView: self, index: currentPage)
        
    }
    
}
//MARK: - 定时器
extension CarouselView {
    // start auto run
    func startAutoRun() {
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(CarouselView.start), userInfo: nil, repeats: true)
    }
    // start
    func start(timer:Timer) {
        scrollView.setContentOffset(CGPoint(x:self.frame.size.width  * 2,y: 0), animated: true)
        
    }
    // stop auto run
    func stopAutoRun() {
        if  ((timer?.isValid) != nil) {
            timer!.invalidate()
            timer = nil
        }
    }
    // reset timer
    func resetTimer() {
        if  ((timer?.isValid) != nil) {
            timer!.invalidate()
            timer = nil
        }else {
            
            startAutoRun()
        }
        
    }
    
}
