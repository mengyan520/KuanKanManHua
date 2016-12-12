//
//  HomeViewController.swift
//  kuaikan
//
//  Created by 马鸣 on 2016/12/3.
//  Copyright © 2016年 马鸣. All rights reserved.
//
import UIKit
import MJRefresh
class HomeViewController: BaseViewController {
    var isScroll:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var times = [String]()
        for i in 1 ..< 8 {
            times.append(WeekTools.timeStampWithDate(day: i - 7))
            
        }
        topView.del = self
        topView.items = ["关注","热门"];
        topView.selectedSegmentIndex = 1
        view.addSubview(backscrollView)
        for i in 0..<2 {
            let view = UIView.init(frame: CGRect.init(x: SCREEN_WIDTH * CGFloat(i), y: 0, width: SCREEN_WIDTH, height:SCREEN_HEIGHT-64-49))
            backscrollView.addSubview(view)
            if i == 1 {
                view.addSubview(Titlescrollview)
                
                view.addSubview(scrollView)
                for i in 0..<7 {
                    let vc = HomeTableViewController()
                    addChildViewController(vc)
                    
                    vc.time = times[i]
                    if i == 6 {
                        let btn = (Titlescrollview.subviews[NSInteger(i)] as! UIButton)
                        
                        let vcW = scrollView.frame.size.width
                        let vcH = scrollView.frame.size.height
                        
                        vc.view.frame =  CGRect.init(x: 6 * scrollView.frame.size.width , y: 0, width: vcW, height: vcH)
                        
                        scrollView.addSubview(vc.view)
                        scrollView.setContentOffset(CGPoint.init(x: 6 * scrollView.frame.size.width, y: 0), animated: false)
                        topViewOffset(sender: btn)
                    }
                    
                }
                backscrollView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH, y: 0), animated: false)
            }
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate lazy var backscrollView:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49))
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true;
        view.bounces = false
        view.contentSize = CGSize.init(width: SCREEN_WIDTH * 2, height: 0)
        return view
    }()
    fileprivate lazy var Titlescrollview:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:0, width: SCREEN_WIDTH, height: 40))
        let titles = WeekTools.weekArray(day: WeekTools.getWeek())
        for i in 0..<titles.count {
            
            let btn = UIButton.init(title: titles[i], color: BLACK_COLOR, fontSize: 14, target: self, actionName: #selector(self.topBtnClick(sender:)))
            
            btn.frame = CGRect.init(x: i * 60, y: 0, width: 60, height: 40)
            btn.setTitleColor(RGB(r: 255, g: 209, b: 10, a: 1.0), for: .selected)
            view.addSubview(btn)
            btn.tag = i
            
        }
        view.contentSize = CGSize.init(width: 60 * titles.count, height: 0)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    fileprivate lazy var scrollView:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49-40))
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true;
        view.bounces = false
        view.contentSize = CGSize.init(width: SCREEN_WIDTH * 7, height: 0)
        return view
    }()
    
    fileprivate lazy var currentBtn:UIButton = {
        let btn = UIButton.init()
        
        return btn
    }()
}
// MARK: - 代理方法/自定义方法
extension HomeViewController:UIScrollViewDelegate,NavTopDel{
     func NavTopClick(sender: UISegmentedControl) {
       
             backscrollView.setContentOffset(CGPoint.init(x: SCREEN_WIDTH * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            scrollViewDidEndScrollingAnimation(scrollView)
        }else if scrollView == backscrollView {
            let index = scrollView.contentOffset.x / scrollView.bounds.size.width
            topView.selectedSegmentIndex = Int(index)
        }
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        let btn = (Titlescrollview.subviews[NSInteger(index)] as! UIButton)
        addChildView(index: index)
        topViewOffset(sender: btn)
    }
    func topBtnClick(sender: UIButton) {
        let offsetX = CGFloat(sender.tag) * SCREEN_WIDTH
        
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        addChildView(index: CGFloat(sender.tag))
        topViewOffset(sender: sender)
    }
    
    func addChildView(index:CGFloat)  {
        
        let vc = self.childViewControllers[NSInteger(index)]
        
        if (vc.view.superview != nil) {
            return
        }
        let vcW = scrollView.frame.size.width
        let vcH = scrollView.frame.size.height
        let vcY:CGFloat = 0
        let vcX = index * vcW
        vc.view.frame = CGRect.init(x: vcX, y: vcY, width: vcW, height: vcH)
        scrollView.addSubview(vc.view)
    }
    
    func topViewOffset(sender:UIButton) {
        currentBtn.isSelected = false
        currentBtn = sender
        sender.isSelected = true
        var offset = sender.center.x - Titlescrollview.bounds.size.width*0.8
        let maxoffset = Titlescrollview.contentSize.width - 60 - Titlescrollview.bounds.size.width
        if offset < 0 {
            offset = 0
        }else if offset > maxoffset  {
            offset = maxoffset + 60
        }
        
        Titlescrollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
    }
}
